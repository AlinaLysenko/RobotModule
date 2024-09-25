from robot.libraries.BuiltIn import BuiltIn
from robot.api import logger
from SeleniumLibrary import SeleniumLibrary

class ScreenshotListener:
    def __init__(self):
        self.ROBOT_LIBRARY_LISTENER = self
        self.library = SeleniumLibrary()

    def end_keyword(self, name, attributes):
        if 'screenshot' in attributes['tags']:
            message = f"{attributes['kwname'].replace(' ', '_')}"
            self.take_screenshot(message)

    def take_screenshot(self, message):
        try:
            # Get the Selenium library instance and take a screenshot
            screenshot_path = BuiltIn().get_variable_value("${OUTPUT DIR}") + f"/screenshot-{message}.png"
            self.library.capture_page_screenshot(screenshot_path)
            logger.info(f"Screenshot taken: {screenshot_path}")
        except Exception as e:
            logger.error(f"Failed to take screenshot: {str(e)}")
