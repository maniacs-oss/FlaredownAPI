# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Clear it out first
Entry.all.each{|e| e.destroy}
User.delete_all
Question.delete_all

u=User.create(email: "test@test.com", password: "testing123", password_confirmation: "testing123", gender: "male", weight: 145)

Question.create(name: "ab_pain",        catalog: "cdai", kind: "select", section: 1, group: nil, options: [{value: 0, label: "none", meta_label: "happy_face", helper: nil}, {value: 1, label: "mild", meta_label: "neutral_face", helper: nil}, {value: 2, label: "moderate", meta_label: "frowny_face", helper: nil}, {value: 3, label: "severe", meta_label: "sad_face", helper: nil}])
Question.create(name: "general",        catalog: "cdai", kind: "select", section: 2, group: nil, options: [{value: 0, label: "well", meta_label: "happy_face", helper: nil}, {value: 1, label: "below_par", meta_label: "neutral_face", helper: nil}, {value: 2, label: "poor", meta_label: "frowny_face", helper: nil}, {value: 3, label: "very_poor", meta_label: "sad_face", helper: nil}, {value: 4, label: "terrible", meta_label: "terrible_face", helper: nil}])
Question.create(name: "mass",           catalog: "cdai", kind: "select", section: 3, group: nil, options: [{value: 0, label: "none", meta_label: "happy_face", helper: nil}, {value: 3, label: "questionable", meta_label: nil, helper: nil}, {value: 5, label: "present", meta_label: nil, helper: nil}])
Question.create(name: "stools",         catalog: "cdai", kind: "input", section: 4, group: nil, options: [{value: 0, label: nil, meta_label: nil, helper: "stools_weekly"}])
Question.create(name: "hematocrit",     catalog: "cdai", kind: "input", section: 5, group: nil, options: [{value: 0, label: nil, meta_label: nil, helper: "hematocrit_without_decimal"}])
Question.create(name: "weight_current", catalog: "cdai", kind: "input", section: 6, group: nil, options: [{value: 0, label: nil, meta_label: nil, helper: "current_weight"}])
Question.create(name: "weight_typical", catalog: "cdai", kind: "input", section: 7, group: nil, options: [{value: 0, label: nil, meta_label: nil, helper: "typical_weight"}])
Question.create(name: "opiates",                    catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
Question.create(name: "complication_arthritis",     catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
Question.create(name: "complication_iritis",        catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
Question.create(name: "complication_erythema",      catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
Question.create(name: "complication_fever",         catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
Question.create(name: "complication_fistula",       catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)
Question.create(name: "complication_other_fistula", catalog: "cdai", kind: "checkbox", section: 8, group: "complications", options: nil)

Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 2}, {id: "ab_pain", value: 1}, {id: "general", value: 4}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: true}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: false}, {id: "mass", value: 2}, {id: "hematocrit", value: 40}, {id: "weight_current", value: 140}], date: Time.now-17.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 4}, {id: "ab_pain", value: 1}, {id: "general", value: 4}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: true}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: true}, {id: "mass", value: 5}, {id: "hematocrit", value: 50}, {id: "weight_current", value: 150}], date: Time.now-16.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 1}, {id: "ab_pain", value: 1}, {id: "general", value: 3}, {id: "complication_arthritis", value: false}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: false}, {id: "mass", value: 5}, {id: "hematocrit", value: 40}, {id: "weight_current", value: 140}], date: Time.now-15.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 2}, {id: "ab_pain", value: 2}, {id: "general", value: 4}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: true}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: true}, {id: "opiates",  value: true}, {id: "mass", value: 5}, {id: "hematocrit", value: 40}, {id: "weight_current", value: 130}], date: Time.now-14.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 2}, {id: "ab_pain", value: 2}, {id: "general", value: 4}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: false}, {id: "mass", value: 0}, {id: "hematocrit", value: 38}, {id: "weight_current", value: 140}], date: Time.now-13.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 3}, {id: "ab_pain", value: 1}, {id: "general", value: 4}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: true}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: true}, {id: "mass", value: 0}, {id: "hematocrit", value: 40}, {id: "weight_current", value: 140}], date: Time.now-12.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 2}, {id: "ab_pain", value: 2}, {id: "general", value: 3}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: false}, {id: "mass", value: 5}, {id: "hematocrit", value: 44}, {id: "weight_current", value: 110}], date: Time.now-11.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 3}, {id: "ab_pain", value: 3}, {id: "general", value: 2}, {id: "complication_arthritis", value: false}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: true}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: false}, {id: "mass", value: 2}, {id: "hematocrit", value: 43}, {id: "weight_current", value: 140}], date: Time.now-10.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 2}, {id: "ab_pain", value: 4}, {id: "general", value: 2}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: true}, {id: "mass", value: 5}, {id: "hematocrit", value: 42}, {id: "weight_current", value: 140}], date: Time.now-9.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 1}, {id: "ab_pain", value: 4}, {id: "general", value: 2}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: true}, {id: "complication_erythema", value: true}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: true}, {id: "opiates",  value: false}, {id: "mass", value: 2}, {id: "hematocrit", value: 40}, {id: "weight_current", value: 140}], date: Time.now-8.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 1}, {id: "ab_pain", value: 3}, {id: "general", value: 1}, {id: "complication_arthritis", value: false}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: false}, {id: "mass", value: 2}, {id: "hematocrit", value: 40}, {id: "weight_current", value: 120}], date: Time.now-7.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 2}, {id: "ab_pain", value: 2}, {id: "general", value: 1}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: true}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: false}, {id: "mass", value: 5}, {id: "hematocrit", value: 48}, {id: "weight_current", value: 140}], date: Time.now-6.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 2}, {id: "ab_pain", value: 3}, {id: "general", value: 1}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: false}, {id: "mass", value: 0}, {id: "hematocrit", value: 40}, {id: "weight_current", value: 150}], date: Time.now-5.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 4}, {id: "ab_pain", value: 1}, {id: "general", value: 1}, {id: "complication_arthritis", value: false}, {id: "complication_iritis", value: true}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: true}, {id: "mass", value: 5}, {id: "hematocrit", value: 56}, {id: "weight_current", value: 140}], date: Time.now-4.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 4}, {id: "ab_pain", value: 2}, {id: "general", value: 2}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: true}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: true}, {id: "opiates",  value: false}, {id: "mass", value: 5}, {id: "hematocrit", value: 40}, {id: "weight_current", value: 130}], date: Time.now-3.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 3}, {id: "ab_pain", value: 1}, {id: "general", value: 2}, {id: "complication_arthritis", value: false}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: false}, {id: "mass", value: 5}, {id: "hematocrit", value: 52}, {id: "weight_current", value: 140}], date: Time.now-2.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 2}, {id: "ab_pain", value: 1}, {id: "general", value: 4}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: true}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: false}, {id: "mass", value: 2}, {id: "hematocrit", value: 40}, {id: "weight_current", value: 140}], date: Time.now-1.day)
Entry.create(user: u, catalogs: ["cdai"], responses: [{id: "weight_typical", value: 140}, {id: "stools", value: 2}, {id: "ab_pain", value: 3}, {id: "general", value: 2}, {id: "complication_arthritis", value: true}, {id: "complication_iritis", value: false}, {id: "complication_erythema", value: false}, {id: "complication_fistula", value: false}, {id: "complication_fever", value: true}, {id: "complication_other_fistula", value: false}, {id: "opiates",  value: false}, {id: "mass", value: 5}, {id: "hematocrit", value: 40}, {id: "weight_current", value: 140}], date: Time.now)