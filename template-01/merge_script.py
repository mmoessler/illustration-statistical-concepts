
# import modules
import re

# define functions
def generate_slider(slider_header, button_header, slider_id, slider_value_id, slider_value_max, slider_value, button_id):
    tag = \
        " \
        <p style='font-size: 12pt; text-align: center;'>" + slider_header + "</p><p style='font-size: 12pt; text-align: center' class='sliderValueCl' id='sliderValue" + slider_value_id + "Id'></p> \
        <input class='sliderCl' id='slider" + slider_id + "Id' type='text' data-slider-min='0' data-slider-max='" + slider_value_max + "' data-slider-step='1' data-slider-value='" + slider_value + "'/> \
        <div style='font-size: 12pt; text-align: center;'> \
        <button class='animateButtonCl' id='" + button_id + "' onclick='animateButtonClick(slider = " + slider_id + ")'>" + button_header + "</button> \
        </div>"
    return(tag)

# print(generate_slider(slider_header = "Sample size \(n\)", button_header = "Animate \(n\)", slider_id = "1", slider_value_id = "1", slider_value_max = "4", slider_value = "2", button_id = "1"))
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

# # Print the list of code_chunks
# print("list all code chunks")
# print(code_chunks)

# Loop over the code_chunks and perform the operations
for chunk in code_chunks:
    start_marker = f"<py/{chunk}>"
    end_marker = f"<{chunk}/py>"
    code_block = txt_content.split(start_marker)[1].split(end_marker)[0]
    # Evaluate the code block using exec
    try:
        exec(code_block)
    except Exception as e:
        print(f"An error occurred while executing the code: {e}")

print("code chunk element 1")
print(sliders)
print(len(sliders))
print(sliders["value"]["slider1"])

tag = ""
for ii in range(len(sliders["slider_value"])):
    if ii == 0:
        tag += "<hr>" + generate_slider(slider_header = sliders["slider_header"][ii], button_header = sliders["button_header"][ii], slider_id = str(ii+1), slider_value_id = str(ii+1), slider_value_max = sliders["slider_value_max"][ii], slider_value = sliders["slider_value"][ii], button_id = str(ii+1))
    else:
        tag += "<br>" + generate_slider(slider_header = sliders["slider_header"][ii], button_header = sliders["button_header"][ii], slider_id = str(ii+1), slider_value_id = str(ii+1), slider_value_max = sliders["slider_value_max"][ii], slider_value = sliders["slider_value"][ii], button_id = str(ii+1))

print("this are the slider tags")
print(tag)

html_content = html_content.replace(f"<!-- slider inputs -->", tag)


# Use regular expressions to find all words between </ and >
html_chunks = re.findall(r'<html/(.*?)>', txt_content)
# Filter out any empty strings
html_chunks = [chunk.strip() for chunk in html_chunks if chunk.strip()]

# # Print the list of text_chunks
# print(html_chunks)

# Loop over the text_chunks and perform the operations
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

# print(chunk)
# print(js_block)

# print(f"// {chunk} //")

html_content = html_content.replace(f"// {chunk} //", js_block)

# Write the modified HTML content back to the file
with open('./template-01/html_output.html', 'w') as output_file:
    output_file.write(html_content)
