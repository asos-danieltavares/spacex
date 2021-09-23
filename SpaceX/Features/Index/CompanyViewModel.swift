import Models
import Localization

struct CompanyViewModel {

    let companyInformation: String

    init(companyDetails: CompanyDetails, numberFormatter: NumberFormatter) {
        let employees = numberFormatter.string(from: NSNumber(value: companyDetails.employees))
        let cost = numberFormatter.string(from: NSNumber(value: companyDetails.valuation))

        companyInformation = String(localizedWithParams: .companyDetailsInformation,
                                    params: companyDetails.name,
                                    companyDetails.founder,
                                    String(companyDetails.founded),
                                    employees.orEmpty(),
                                    String(companyDetails.launchSites),
                                    cost.orEmpty())
    }
}
