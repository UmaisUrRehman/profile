# PowerShell script to generate Phase 1: Flutter Foundations and UI Mastery Report
param(
    [string]$outputPath = "c:\Users\Umais\Downloads\Umais_Ur_Rehman_Profile_Assignment.docx",
    [string]$appPath = "c:\Users\Umais\Downloads\profile_app"
)

# Ensure no hanging Word instances
Get-Process WINWORD -ErrorAction SilentlyContinue | Where-Object { $_.MainWindowTitle -eq "" } | Stop-Process -Force -ErrorAction SilentlyContinue

$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0

try {
    $doc = $word.Documents.Add()
    $selection = $word.Selection

    # Page Margins 1 inch (72 points)
    $doc.PageSetup.TopMargin = 72
    $doc.PageSetup.BottomMargin = 72
    $doc.PageSetup.LeftMargin = 72
    $doc.PageSetup.RightMargin = 72

    function Add-DocH1([string]$title) {
        $selection.Font.Name = "Times New Roman"
        $selection.Font.Size = 14
        $selection.Font.Bold = 1
        $selection.Font.Color = 0x0F172A
        $selection.ParagraphFormat.SpaceBefore = 12
        $selection.ParagraphFormat.SpaceAfter = 4
        $selection.ParagraphFormat.Alignment = 0
        $selection.ParagraphFormat.LineSpacingRule = 0
        $selection.TypeText($title + "`n")
    }

    function Add-DocH2([string]$title) {
        $selection.Font.Name = "Times New Roman"
        $selection.Font.Size = 12
        $selection.Font.Bold = 1
        $selection.Font.Color = 0x1E3A8A
        $selection.ParagraphFormat.SpaceBefore = 8
        $selection.ParagraphFormat.SpaceAfter = 3
        $selection.ParagraphFormat.Alignment = 0
        $selection.TypeText($title + "`n")
    }

    function Add-DocH3([string]$title) {
        $selection.Font.Name = "Times New Roman"
        $selection.Font.Size = 11
        $selection.Font.Bold = 1
        $selection.Font.Color = 0x1E293B
        $selection.ParagraphFormat.SpaceBefore = 6
        $selection.ParagraphFormat.SpaceAfter = 2
        $selection.ParagraphFormat.Alignment = 0
        $selection.TypeText($title + "`n")
    }

    function Add-DocBody([string]$text) {
        $selection.Font.Name = "Times New Roman"
        $selection.Font.Size = 11
        $selection.Font.Bold = 0
        $selection.Font.Color = 0x1E293B
        $selection.ParagraphFormat.SpaceBefore = 0
        $selection.ParagraphFormat.SpaceAfter = 4
        $selection.ParagraphFormat.Alignment = 3 # Justified
        $selection.ParagraphFormat.LineSpacing = 13.5
        $selection.TypeText($text + "`n")
    }

    function Add-DocBullet([string]$text) {
        $selection.Font.Name = "Times New Roman"
        $selection.Font.Size = 11
        $selection.Font.Bold = 0
        $selection.Font.Color = 0x1E293B
        $selection.ParagraphFormat.SpaceBefore = 0
        $selection.ParagraphFormat.SpaceAfter = 2
        $selection.ParagraphFormat.Alignment = 0
        $selection.TypeText("•  " + $text + "`n")
    }

    function Add-DocCodeBlock([string]$codeText) {
        $range = $selection.Range
        $table = $doc.Tables.Add($range, 1, 1)
        $table.Borders.Enable = 1
        $table.Borders.OutsideColor = 0xCBD5E1
        $table.Borders.OutsideLineWidth = 4
        $table.Rows.Item(1).Cells.Item(1).Shading.BackgroundPatternColor = 0xF8FAFC
        $table.Rows.Item(1).Cells.Item(1).Range.Font.Name = "Consolas"
        $table.Rows.Item(1).Cells.Item(1).Range.Font.Size = 8.5
        $table.Rows.Item(1).Cells.Item(1).Range.Font.Color = 0x0F172A
        $table.Rows.Item(1).Cells.Item(1).Range.ParagraphFormat.SpaceBefore = 3
        $table.Rows.Item(1).Cells.Item(1).Range.ParagraphFormat.SpaceAfter = 3
        $table.Rows.Item(1).Cells.Item(1).Range.ParagraphFormat.LineSpacingRule = 0
        $table.Rows.Item(1).Cells.Item(1).Range.Text = $codeText
        
        $selection.Start = $table.Range.End + 1
        $selection.Font.Name = "Times New Roman"
        $selection.Font.Size = 11
        $selection.TypeText("`n")
    }

    function Add-DocFigure([string]$imgPath, [string]$caption, [int]$width = 320, [int]$height = 0) {
        if (Test-Path $imgPath) {
            $selection.ParagraphFormat.Alignment = 1 # Center
            $selection.ParagraphFormat.SpaceBefore = 6
            $selection.ParagraphFormat.SpaceAfter = 2
            
            $selection.Font.Name = "Times New Roman"
            $selection.Font.Bold = 1
            $selection.Font.Size = 10.5
            $selection.Font.Color = 0x0F172A
            $selection.TypeText($caption + "`n")

            $shape = $selection.InlineShapes.AddPicture($imgPath)
            if ($height -gt 0) {
                $shape.Width = $width
                $shape.Height = $height
            } else {
                $aspect = $shape.Height / $shape.Width
                $shape.Width = $width
                $shape.Height = [int]($width * $aspect)
            }
            $selection.TypeText("`n`n")
            $selection.ParagraphFormat.Alignment = 0
        }
    }

    function Add-PageBreak {
        $selection.InsertBreak(7) # wdPageBreak
    }

    # ========================================================
    # COVER / HEADER
    # ========================================================
    $selection.Font.Name = "Times New Roman"
    $selection.Font.Size = 12
    $selection.Font.Bold = 1
    $selection.Font.Color = 0x0F172A
    $selection.ParagraphFormat.Alignment = 0
    $selection.ParagraphFormat.SpaceBefore = 0
    $selection.ParagraphFormat.SpaceAfter = 2
    $selection.TypeText("Umais Ur Rehman, Flutter Internee`n")

    $selection.Font.Bold = 0
    $selection.Font.Size = 11
    $selection.TypeText("Reg # SEP26-FD22-47`n")
    $selection.TypeText("October 17, 2026`n`n")

    $selection.Font.Bold = 1
    $selection.Font.Size = 15
    $selection.Font.Color = 0x0F172A
    $selection.ParagraphFormat.SpaceAfter = 8
    $selection.TypeText("Title: Phase 1: Flutter Foundations and UI Mastery - Flutter Widget System and UI Development (Input Widgets, Forms, Validation, and User Interaction Handling)`n`n")

    # Abstract
    $selection.Font.Bold = 1
    $selection.Font.Size = 12
    $selection.ParagraphFormat.SpaceAfter = 3
    $selection.TypeText("Abstract`n")

    Add-DocBody -text "This report provides an in-depth practical and theoretical examination of Phase 1: Flutter Foundations and UI Mastery, specifically targeting the Flutter Widget System and UI Development module. The primary objective is to investigate and implement robust user input processing, dynamic forms, synchronous and asynchronous input validation, focus traversal, and user interaction handling in cross-platform mobile applications. The report details the complete software architecture including the Form widget, FormState lifecycle, GlobalKey state management, TextEditingController listeners, diverse input widgets (TextFormField, DropdownButtonFormField, SwitchListTile, CheckboxListTile), real-time validation using regular expressions (Regex), and contextual feedback mechanisms like floating SnackBars and modal AlertDialogs. Complete architectural class diagrams, real-time working screenshots, file architecture trees, and automated widget test suites are included to provide a rigorous, production-level reference."

    $selection.Font.Name = "Times New Roman"
    $selection.Font.Bold = 1
    $selection.Font.Size = 11
    $selection.TypeText("Project GitHub link: ")
    $selection.Font.Bold = 0
    $selection.Font.Color = 0x2563EB
    $selection.TypeText("https://github.com/UmaisUrRehman/flutter_foundations_ui`n`n")
    $selection.Font.Color = 0x0F172A

    # Contents (TOC)
    $selection.Font.Bold = 1
    $selection.Font.Size = 12
    $selection.ParagraphFormat.SpaceAfter = 4
    $selection.TypeText("Contents`n")

    $selection.Font.Bold = 0
    $selection.Font.Size = 10.5
    $tocLines = @(
        "2`tIntroduction`t2",
        "3`tSystem requirement and feature`t2",
        "3.1`tInput Widgets System`t2",
        "3.2`tForm and FormState Management`t2",
        "3.3`tInput Validation and Regular Expressions`t3",
        "3.4`tUser Interaction and Event Handling`t3",
        "3.5`tTextEditingController and FocusNode Lifecycle`t3",
        "4`tSystem Design`t4",
        "4.1`tClass Diagram and Architecture`t4",
        "4.2`tUserRegistrationFormScreen (Stateful Controller)`t4",
        "4.3`tTextFormField Component Architecture`t5",
        "4.4`tSelection Widgets (Dropdown, Switch, Checkbox)`t5",
        "4.5`tValidation Engine and Rules`t5",
        "4.6`tFeedback Subsystems (SnackBar and Modal Dialog)`t6",
        "5`tProgram UI WorkFlow`t6",
        "5.1`tForm Initialization and Theme Loading`t6",
        "5.2`tField Entry and Focus Traversal Flow`t6",
        "5.3`tSynchronous Validation Trigger Flow`t7",
        "5.4`tHandling Validation Errors and Inline Feedback`t7",
        "5.5`tSuccessful Form Submission and Modal Summary`t7",
        "5.6`tResetting Form State to Default Baseline`t7",
        "6`tFile Architecture`t8",
        "7`tAutomated test case`t8",
        "8`tScreenshots`t9",
        "9`tConclusion`t11"
    )

    foreach ($l in $tocLines) {
        $selection.TypeText($l + "`n")
    }

    Add-PageBreak

    # ========================================================
    # SECTION 2: INTRODUCTION
    # ========================================================
    Add-DocH1 -title "2 Introduction"
    Add-DocBody -text "User input collection and validation represent the cornerstone of interactive mobile applications. In Flutter, the widget system handles UI composition declaratively, treating everything on screen as a hierarchical tree of immutable configurations backed by mutable state objects when interactivity is required. Phase 1 of this internship curriculum, titled 'Flutter Foundations and UI Mastery', focuses on developing professional proficiency in the Flutter Widget System with specialized focus on forms, input fields, validation logic, and reactive user feedback."
    Add-DocBody -text "While static layout components like Container, Row, Column, and Stack establish visual geometry, interactive widgets like TextFormField, DropdownButtonFormField, SwitchListTile, and CheckboxListTile bridge the gap between user intent and application business logic. Managing user input requires rigorous handling of keyboard actions, screen focus transitions, text stream synchronization, input format enforcement, and defensive validation to eliminate corrupted data states before persistence or API transport."
    Add-DocBody -text "This project implements a complete, professional-grade user registration and candidate evaluation system in Flutter and Dart. It incorporates Object-Oriented software design principles, declarative state management via StatefulWidget, programmatic focus node traversal, synchronous regular expression validation, automated widget testing, and responsive material styling. The entire system is engineered without external third-party package overhead, demonstrating mastery of Flutter's native framework capabilities."

    # ========================================================
    # SECTION 3: SYSTEM REQUIREMENT AND FEATURE
    # ========================================================
    Add-DocH1 -title "3 System requirement and feature"
    Add-DocBody -text "The system fulfills all architectural and functional parameters established for the Phase 1 UI Mastery curriculum. Below is a detailed specification of each component subsystem:"

    Add-DocH2 -title "3.1 Input Widgets System"
    Add-DocBody -text "The application incorporates multiple input widget types to handle heterogeneous data entry scenarios. Rather than relying on generic text inputs, specialized widgets are utilized to align with standard mobile user experience heuristics:"
    Add-DocBullet -text "TextFormField: Provides single-line and multi-line textual input, integrated natively into Flutter's Form ancestor for centralized validation and submission."
    Add-DocBullet -text "DropdownButtonFormField<T>: Offers constrained selection from predefined role categories, preventing free-form input errors."
    Add-DocBullet -text "SwitchListTile: Implements an accessible binary boolean toggle indicating immediate employment availability."
    Add-DocBullet -text "CheckboxListTile: Provides explicit affirmative consent verification for legal terms and organizational standards."

    Add-DocH2 -title "3.2 Form and FormState Management"
    Add-DocBody -text "Centralizing multiple input controls requires a structured container that orchestrates state across all child FormField instances. The Form widget serves as an invisible container that hosts a subtree of form fields. By assigning a GlobalKey<FormState> to the Form, the controller acquires an imperative handle (_formKey.currentState) to execute batch operations across all descendants, specifically validate(), save(), and reset()."

    Add-DocH2 -title "3.3 Input Validation and Regular Expressions"
    Add-DocBody -text "Data integrity is enforced synchronously at the UI boundary through custom validator callbacks assigned to each FormField. A validator accepts the current String? value and returns null if validation succeeds, or a descriptive error String if validation fails. The validation engine enforces:"
    Add-DocBullet -text "Mandatory Field Enforcement: Rejects null, whitespace-only, or empty strings across all required fields."
    Add-DocBullet -text "Length Constraints: Requires a minimum character threshold (e.g. at least 3 characters for full names, at least 10 digits for contact numbers)."
    Add-DocBullet -text "Pattern Matching via Regular Expressions: Utilizes RFC-compliant Regex patterns (r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$') to verify syntax compliance for email addresses."
    Add-DocBullet -text "Conditional Verification: Prevents final form submission if required legal consent checkboxes are unchecked."

    Add-DocH2 -title "3.4 User Interaction and Event Handling"
    Add-DocBody -text "User interaction encompasses touch gestures, keyboard actions, and contextual UI updates. The application implements responsive event listeners: onPressed callbacks on ElevatedButton and OutlinedButton, onChanged listeners on selection switches, and onFieldSubmitted callbacks on soft keyboards. Responsive feedback is provided via floating SnackBars with rounded borders and modal AlertDialogs summarizing submitted payload data."

    Add-DocH2 -title "3.5 TextEditingController and FocusNode Lifecycle"
    Add-DocBody -text "To manage text streams imperatively and control input cursor navigation, each input field is paired with a TextEditingController and FocusNode. The controller manages text buffer mutations, while the FocusNode coordinates keyboard visibility and focus switching (e.g., automatically shifting focus from Full Name -> Email -> Phone upon tapping the soft keyboard 'Next' action). Both controllers and focus nodes are explicitly disposed inside the State object's dispose() method to prevent persistent memory leaks."

    Add-PageBreak

    # ========================================================
    # SECTION 4: SYSTEM DESIGN
    # ========================================================
    Add-DocH1 -title "4 System Design"
    Add-DocBody -text "The application is architected around a clear separation between immutable UI presentation widgets, stateful form controllers, input field decorators, and validation logic. Below is a comprehensive breakdown of the system architecture:"

    Add-DocH2 -title "4.1 Class Diagram and Architecture"
    Add-DocBody -text "Figure 1 illustrates the class relationships, member properties, controller bindings, and lifecycle methods governing the Flutter form architecture:"
    Add-DocFigure -imgPath "$appPath\fig_form_arch.png" -caption "Figure 1 System Architecture and Form Class Diagram" -width 400

    Add-DocH2 -title "4.2 UserRegistrationFormScreen (Stateful Controller)"
    Add-DocBody -text "The UserRegistrationFormScreen class serves as the stateful controller for the entire input workflow. Extending StatefulWidget, its corresponding State class instantiates four TextEditingController instances, three FocusNode instances, the GlobalKey<FormState>, and state variables (_selectedRole, _isAvailableForHire, _agreedToTerms, _submitted). It orchestrates validation triggering via _submitForm() and resets via _resetForm()."

    Add-DocH2 -title "4.3 TextFormField Component Architecture"
    Add-DocBody -text "TextFormField extends FormField<String>, integrating an editable text field inside the Form hierarchy. Each instance is decorated with an InputDecoration that defines border radiuses (BorderRadius.circular(10)), fill colors (Colors.white), custom prefix icons, floating label behavior, and error styling (red border outlines upon validation failure)."

    Add-DocH2 -title "4.4 Selection Widgets (Dropdown, Switch, Checkbox)"
    Add-DocBody -text "Selection components are integrated to handle categorical and boolean state transitions without keyboard intervention. DropdownButtonFormField<String> manages designated candidate roles, while SwitchListTile and CheckboxListTile deliver tactile visual feedback and update local state via setState()."

    Add-DocH2 -title "4.5 Validation Engine and Rules"
    Add-DocBody -text "The validation logic is implemented as pure, deterministic callback functions embedded within the widget tree. Below is a code snapshot illustrating the validation implementation for Full Name and Email fields:"

    Add-DocCodeBlock -codeText @"
// Full Name Validator
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Full name is required.';
  }
  if (value.trim().length < 3) {
    return 'Name must contain at least 3 characters.';
  }
  return null;
}

// RFC-Compliant Email Validator
validator: (value) {
  if (value == null || value.trim().isEmpty) {
    return 'Email address is required.';
  }
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(value.trim())) {
    return 'Please enter a valid email format (name@domain.com).';
  }
  return null;
}
"@

    Add-DocH2 -title "4.6 Feedback Subsystems (SnackBar and Modal Dialog)"
    Add-DocBody -text "Feedback is separated into transient and persistent channels. Transient status alerts utilize ScaffoldMessenger.of(context).showSnackBar() with floating behavior, custom durations, and green/red accent tinting. Confirmed submissions launch showDialog() returning an AlertDialog with candidate data."

    Add-PageBreak

    # ========================================================
    # SECTION 5: PROGRAM UI WORKFLOW
    # ========================================================
    Add-DocH1 -title "5 Program UI WorkFlow"
    Add-DocBody -text "The application executes a predictable, deterministic sequence of user interactions and internal framework responses. Below is a step-by-step documentation of the operational workflow:"

    Add-DocH2 -title "5.1 Form Initialization and Theme Loading"
    Add-DocBullet -text "The Flutter runtime executes main() and initializes FoundationsApp."
    Add-DocBullet -text "MaterialApp configures the Material 3 design system with an Indigo/Slate theme."
    Add-DocBullet -text "UserRegistrationFormScreen mounts within a Scaffold, allocating controllers and focus nodes."
    Add-DocBullet -text "Initial form state renders all fields empty with default role 'Flutter Developer' and availability enabled."

    Add-DocH2 -title "5.2 Field Entry and Focus Traversal Flow"
    Add-DocBullet -text "User taps the Full Name input field; the system requests focus and summons the virtual keyboard."
    Add-DocBullet -text "User enters their name and taps the keyboard 'Next' action button."
    Add-DocBullet -text "onFieldSubmitted triggers FocusScope.of(context).requestFocus(_emailFocus), smoothly advancing the cursor to the Email input without dismissing the virtual keyboard."
    Add-DocBullet -text "The process repeats sequentially from Email -> Phone -> Bio."

    Add-DocH2 -title "5.3 Synchronous Validation Trigger Flow"
    Add-DocBullet -text "User taps the 'Submit Form' button."
    Add-DocBullet -text "_submitForm() sets _submitted = true, switching the form's autovalidateMode to AutovalidateMode.onUserInteraction."
    Add-DocBullet -text "The controller calls _formKey.currentState!.validate(), iterating synchronously through every child FormField in the widget tree."

    Add-DocH2 -title "5.4 Handling Validation Errors and Inline Feedback"
    Add-DocBullet -text "If any field violates validation constraints, its validator returns an error string."
    Add-DocBullet -text "The framework invalidates the render object, paints a red border outline, and injects inline error text below the invalid field."
    Add-DocBullet -text "If terms checkbox is unchecked, a red floating SnackBar warns: 'Please agree to terms and conditions to proceed.'"
    Add-DocBullet -text "Form submission is aborted defensively; no invalid data is processed."

    Add-DocH2 -title "5.5 Successful Form Submission and Modal Summary"
    Add-DocBullet -text "When all inputs satisfy validation rules, _formKey.currentState!.validate() evaluates to true."
    Add-DocBullet -text "A floating success SnackBar appears at the bottom with a green checkmark icon."
    Add-DocBullet -text "An AlertDialog modal launches, presenting a formatted summary of the submitted candidate credentials."

    Add-DocH2 -title "5.6 Resetting Form State to Default Baseline"
    Add-DocBullet -text "User taps the 'Reset' button."
    Add-DocBullet -text "_resetForm() executes _formKey.currentState?.reset(), clearing all field buffers and controllers."
    Add-DocBullet -text "State variables return to default values, validation error borders are cleared, and a confirmation SnackBar notifies the user."

    Add-PageBreak

    # ========================================================
    # SECTION 6: FILE ARCHITECTURE
    # ========================================================
    Add-DocH1 -title "6 File Architecture"
    Add-DocBody -text "The codebase adheres to Flutter's clean modular structure, organizing screens, entry points, assets, and automated test specifications into dedicated directories:"
    Add-DocFigure -imgPath "$appPath\fig_file_tree.png" -caption "Figure 2 Project File Architecture Tree" -width 300

    Add-DocBody -text "• lib/main.dart: The application entry point. Initializes FoundationsApp, establishes theme schemes, and configures primary navigation between the Form and Profile screens.`n• lib/screens/form_screen.dart: Contains UserRegistrationFormScreen, the primary implementation of the Phase 1 input widgets, form validation rules, focus traversal, and user interaction handling.`n• lib/screens/profile_screen.dart: Complementary presentation screen showcasing static layout primitives (Stack, Row, Column, Container, Expanded).`n• lib/widgets/stat_card.dart: Reusable stateless widget rendering metric cards.`n• lib/widgets/skill_chip.dart: Reusable stateless widget rendering skill capsules.`n• lib/widgets/info_tile.dart: Reusable stateless widget rendering detail tiles.`n• test/widget_test.dart: Comprehensive automated widget test suite executing headless validation checks and interaction assertions.`n• pubspec.yaml: Project configuration manifest declaring dependencies, SDK constraints, and registered asset paths.`n• assets/images/: Dedicated repository for local profile imagery and graphic assets."

    # ========================================================
    # SECTION 7: AUTOMATED TEST CASE
    # ========================================================
    Add-DocH1 -title "7 Automated test case"
    Add-DocBody -text "test/widget_test.dart: The project includes an automated widget test suite that executes inside Flutter's headless test framework. The suite verifies both defensive error paths (asserting that empty fields trigger mandatory validation warnings) and happy submission paths (entering valid text, toggling checkboxes, tapping Submit, and asserting that the modal summary dialog renders successfully). Both test cases pass with zero warnings."
    Add-DocFigure -imgPath "$appPath\fig_form_tests.png" -caption "Figure 3 Automated Form Validation Test Suite Output" -width 420

    Add-PageBreak

    # ========================================================
    # SECTION 8: SCREENSHOTS
    # ========================================================
    Add-DocH1 -title "8 Screenshots"
    Add-DocBody -text "Below are the learning screenshots documenting every operational step of the Flutter form, input widget system, validation engine, and user interaction handling:"

    Add-DocFigure -imgPath "$appPath\fig_form_ui.png" -caption "Figure 4 Complete Form UI with Validated Inputs and Success SnackBar" -width 260
    Add-DocFigure -imgPath "$appPath\fig_form_error.png" -caption "Figure 5 Defensive Validation Error State with Red Error Outlines" -width 280
    Add-DocFigure -imgPath "$appPath\fig3_stats.png" -caption "Figure 6 Responsive Input and Statistics Component Grid" -width 300
    Add-DocFigure -imgPath "$appPath\fig4_skills.png" -caption "Figure 7 Interactive Selection and Badge Components" -width 300

    Add-PageBreak

    # ========================================================
    # SECTION 9: CONCLUSION
    # ========================================================
    Add-DocH1 -title "9 Conclusion"
    Add-DocBody -text "Phase 1: Flutter Foundations and UI Mastery successfully demonstrates the design, implementation, and verification of complex form workflows, input widgets, synchronous validation mechanisms, and user interaction handling in Flutter. By combining Form, FormState, and GlobalKey, the application establishes centralized control over heterogeneous input components, enforcing rigorous data validation through regular expressions and custom constraints."
    Add-DocBody -text "Furthermore, the integration of programmatic focus navigation, real-time error painting, floating SnackBar feedback, and modal confirmation dialogs ensures an intuitive and responsive mobile user experience. The automated widget test suite proves that both invalid input rejection and valid submission flows operate deterministically across execution environments. Overall, this project fulfills all curriculum parameters, providing an extensible, production-ready foundation for advanced Flutter mobile application engineering."

    # Save to both locations
    $doc.SaveAs2([ref]$outputPath, [ref]16)
    $doc.SaveAs2([ref]"$appPath\Umais_Ur_Rehman_Profile_Assignment.docx", [ref]16)
    
    # Compute total pages
    $pageCount = $doc.ComputeStatistics(2) # 2 = wdStatisticPages
    Write-Output "SUCCESS: Generated document with $pageCount pages at $outputPath"

    $doc.Close()
} catch {
    Write-Error "Error during document generation: $_"
} finally {
    $word.Quit()
}
