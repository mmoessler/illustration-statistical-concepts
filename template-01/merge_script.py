
# import modules
import re

# funtion to generate slider
def generate_slider(slider_header, button_header, slider_id, slider_value_id, slider_value_max, slider_value, button_id):
    tag = f"""
        <p style='font-size: 12pt; text-align: center;'>{slider_header}</p>
        <p style='font-size: 12pt; text-align: center' class='sliderValueCl' id='sliderValue{slider_value_id}Id'></p>
        <input class='sliderCl' id='slider{slider_id}Id' type='text' data-slider-min='0' data-slider-max='{slider_value_max}' data-slider-step='1' data-slider-value='{slider_value}'/>
        <div style='font-size: 12pt; text-align: center;'>
            <button class='animateButtonCl' id='{button_id}' onclick='animateButtonClick(slider = {slider_id})'>{button_header}</button>
        </div>
    """
    return tag

# function to generate audio text
def generate_audio_text(n_figures, n_sliders):
    tag = ""
    # loop over figures
    for ii in range(n_figures):
        tag = tag + f"""
            <div id="audioTextFigure{ii+1}OverallId" class="audioTextCl">
            <!-- audio_text_figure_0{ii+1}_overall -->      
            </div>
        """
        # loop over sliders
        for jj in range(n_sliders):
            tag = tag + f"""
                <div id="audioTextFigure{ii+1}Slider{jj+1}Id" class="audioTextCl">          
                <!-- audio_text_figure_0{ii+1}_slider_0{jj+1} -->
                </div>
            """
    return tag

# Read the content of the .txt file
with open('./template-01/input_chunks.txt', 'r') as txt_file:
    txt_content = txt_file.read()

# Read the content of the .html file
with open('./template-01/html_template.html', 'r') as html_file:
    html_content = html_file.read()

# Use regular expressions to find all python code chunks
code_chunks = re.findall(r'<py/(.*?)>', txt_content)
# Filter out any empty strings
code_chunks = [chunk.strip() for chunk in code_chunks if chunk.strip()]
# Loop over the python code chunks and evaluate coe chunks
for chunk in code_chunks:
    start_marker = f"<py/{chunk}>"
    end_marker = f"<{chunk}/py>"
    code_block = txt_content.split(start_marker)[1].split(end_marker)[0]
    # Evaluate the code block using exec
    try:
        exec(code_block)
    except Exception as e:
        print(f"An error occurred while executing the code: {e}")

# generate sliders tag
tag = ""
for ii in range(len(sliders["slider_value"])):
    if ii == 0:
        tag += "<hr>" + generate_slider(slider_header = sliders["slider_header"][ii], button_header = sliders["button_header"][ii], slider_id = str(ii+1), slider_value_id = str(ii+1), slider_value_max = sliders["slider_value_max"][ii], slider_value = sliders["slider_value"][ii], button_id = str(ii+1))
    else:
        tag += "<br>" + generate_slider(slider_header = sliders["slider_header"][ii], button_header = sliders["button_header"][ii], slider_id = str(ii+1), slider_value_id = str(ii+1), slider_value_max = sliders["slider_value_max"][ii], slider_value = sliders["slider_value"][ii], button_id = str(ii+1))
# add slider tags
html_content = html_content.replace(f"<!-- slider_inputs -->", tag)

# generate audio tag
tag = generate_audio_text(n_figures=3, n_sliders=len(sliders["value"]))
html_content = html_content.replace(f"<!-- audio_text_inputs -->", tag)

# Use regular expressions to find all html code chunks
html_chunks = re.findall(r'<html/(.*?)>', txt_content)
# Filter out any empty strings
html_chunks = [chunk.strip() for chunk in html_chunks if chunk.strip()]
# Loop over the html code chunks and insert html template
for chunk in html_chunks:
    start_marker = f"<html/{chunk}>"
    end_marker = f"<{chunk}/html>"
    html_block = txt_content.split(start_marker)[1].split(end_marker)[0]
    html_content = html_content.replace(f"<!-- {chunk} -->", html_block)

# transform python to javascript and insert
chunk = "code_01"
start_marker = f"<py/{chunk}>"
end_marker = f"<{chunk}/py>"
code_block = txt_content.split(start_marker)[1].split(end_marker)[0]
# Remove leading and trailing whitespaces
js_block = code_block.strip()
# Replace double quotes with single quotes
js_block = js_block.replace('"', "'")
# Replace the variable assignment to use 'var'
js_block = js_block.replace("sliders =", "var sliders =")
# insert in html template
html_content = html_content.replace(f"// {chunk} //", js_block)

# Write the modified HTML content back to the file
with open('./template-01/html_output.html', 'w') as output_file:
    output_file.write(html_content)
