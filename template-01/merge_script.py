
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

print(generate_slider(slider_header = "Sample size \(n\)", button_header = "Animate \(n\)", slider_id = "1", slider_value_id = "1", slider_value_max = "4", slider_value = "2", button_id = "1"))

# Read the content of the .txt file
with open('./ber-dis-sam-ave-test/ber_dis_sam_ave.txt', 'r') as txt_file:
    txt_content = txt_file.read()

# Read the content of the .html file
with open('./ber-dis-sam-ave-test/ber_dis_sam_ave_template.html', 'r') as html_file:
    html_content = html_file.read()

# Use regular expressions to find all words between <</ and >>
code_chunks = re.findall(r'<</(.*?)>>', txt_content)
# Filter out any empty strings
code_chunks = [chunk.strip() for chunk in code_chunks if chunk.strip()]

# Print the list of code_chunks
print(code_chunks)

# Loop over the code_chunks and perform the operations
for chunk in code_chunks:
    start_marker = f"<<{chunk}>>"
    end_marker = f"<</{chunk}>>"
    code_block = txt_content.split(start_marker)[1].split(end_marker)[0]
    # Evaluate the code block using exec
    try:
        exec(code_block)
    except Exception as e:
        print(f"An error occurred while executing the code: {e}")

# Use regular expressions to find all words between </ and >
text_chunks = re.findall(r'</(.*?)>', txt_content)
# Filter out any empty strings
text_chunks = [text_chunks.strip() for text_chunks in text_chunks if text_chunks.strip()]

# Print the list of text_chunks
print(text_chunks)

# Filter out any empty strings
text_chunks = [chunk.strip() for chunk in text_chunks if chunk.strip()]

# Loop over the text_chunks and perform the operations
for chunk in text_chunks:
    start_marker = f"<{chunk}>"
    end_marker = f"</{chunk}>"
    text_block = txt_content.split(start_marker)[1].split(end_marker)[0]
    html_content = html_content.replace(f"<!-- {chunk} -->", text_block)

# Write the modified HTML content back to the file
with open('./ber-dis-sam-ave-test/ber_dis_sam_ave.html', 'w') as output_file:
    output_file.write(html_content)
