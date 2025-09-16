<template>
    <v-toolbar density="compact">
        <v-toolbar-title> Total : {{ filteredCards.length }}</v-toolbar-title>
        <v-spacer></v-spacer>
        <v-btn icon="mdi-filter" @click.stop="filterPanelOpened = !filterPanelOpened"></v-btn>
    </v-toolbar>
    <v-container fluid>
        <!-- horizontal panel for filters on small screen -->
        <v-row v-if="smAndDown && filterPanelOpened">
            <v-col>
                <v-card title="Filters">
                    <template v-slot:append>
                        <v-btn @click="removeFilter()" prepend-icon="mdi-filter-remove">Reset</v-btn>
                    </template>
                    <v-card-text>
                        <v-row>
                            <v-col>
                                <!-- {{ minYear }} -->
                                <v-range-slider v-model="selectedYears" step="1" :max="maxYear" :min="minYear"
                                    thumb-label="always"></v-range-slider>
                                <!-- {{ maxYear }} -->
                            </v-col>
                        </v-row>
                        <v-row dense>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Inputs</h3>
                                <v-checkbox v-for="input in inputs" :label="input" :value="input" density="compact"
                                    v-model="selectedInput" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Outputs</h3>
                                <v-checkbox v-for="output in outputs" :label="output" :value="output" density="compact"
                                    v-model="selectedOutputs" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Display technologies</h3>
                                <v-checkbox v-for="devTech in delivTechnologies" :label="devTech" :value="devTech"
                                    density="compact" v-model="selectedDevTech" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Input technologies</h3>
                                <v-checkbox v-for="recepTech in recepTechnologies" :label="recepTech" :value="recepTech"
                                    density="compact" v-model="selectedRecepTech" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Objects</h3>
                                <v-checkbox v-for="object in objects" :label="object" :value="object" density="compact"
                                    v-model="selectedObject" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4" xs="4" sm="2">
                                <h3>Origins</h3>
                                <v-checkbox v-for="origin in origins" :label="origin" :value="origin" density="compact"
                                    v-model="selectedOrigin" hide-details></v-checkbox>
                            </v-col>

                        </v-row>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
        <v-row class="full-height">
            <v-col cols="12" :md="filterPanelOpened ? 8 : 12">
                <v-row>
                    <v-col cols="12">
                        <v-card>
                            <v-card-title>
                                Evolution of TUI Systems Frequency by Year
                            </v-card-title>
                            <v-card-text>
                                <div style="height: 400px;">
                                    <Line id="timeline-chart-id" :options="timelineChartOptions" :data="timelineChartData"
                                        :key="timelineChartKey" />
                                </div>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12" md="6">
                        <v-card>
                            <v-card-title>
                                Distribution of Input Modalities
                            </v-card-title>
                            <v-card-text>
                                <div style="height: 300px;">
                                    <Bar id="input-chart-id" :options="inputsChartOptions" :data="inputChartData"
                                        :key="inputsChartKey" />
                                </div>
                            </v-card-text>
                        </v-card>
                    </v-col>
                    <v-col cols="12" md="6">
                        <v-card>
                            <v-card-title>
                                Distribution of Output Modalities
                            </v-card-title>
                            <v-card-text>
                                <div style="height: 300px;">
                                    <Bar id="output-chart-id" :options="outputsChartOptions" :data="outputChartData"
                                        :key="outputsChartKey" />
                                </div>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col cols="12" md="6">
                        <v-card>
                            <v-card-title>
                                Distribution of Input Technologies
                            </v-card-title>
                            <v-card-text>
                                <div style="height: 300px;">
                                    <Bar id="input-tech-chart-id" :options="inputsTechChartOptions" :data="inputsTechChartData"
                                        :key="inputsTechChartKey" />
                                </div>
                            </v-card-text>
                        </v-card>
                    </v-col>
                    <v-col cols="12" md="6">
                        <v-card>
                            <v-card-title>
                                Distribution of Display Technologies
                            </v-card-title>
                            <v-card-text>
                                <div style="height: 300px;">
                                    <Bar id="display-tech-chart-id" :options="displayTechChartOptions" :data="displayTechChartData"
                                        :key="displayTechChartKey" />
                                </div>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>
                <v-row>
                    <v-col>
                        <v-card>
                            <v-card-title>
                                Distribution of Object Characteristics
                            </v-card-title>
                            <v-card-text>
                                <div style="height: 300px;">
                                    <Bar id="objects-chart-id" :options="objectsChartOptions" :data="objectsChartData"
                                        :key="objectsChartKey" />
                                </div>
                            </v-card-text>
                        </v-card>
                    </v-col>
                </v-row>

            </v-col>

            <!-- Vertical panel for filters on large screen -->
            <v-col v-if="filterPanelOpened && mdAndUp" cols="12" md="4">
                <v-card title="Filters">
                    <template v-slot:append>
                        <v-btn @click="removeFilter()" prepend-icon="mdi-filter-remove">Reset</v-btn>
                    </template>
                    <v-card-text>
                        <v-row>
                            <v-col>
                                <!-- {{ minYear }} -->
                                <v-range-slider v-model="selectedYears" step="1" :max="maxYear" :min="minYear"
                                    thumb-label="always"></v-range-slider>
                                <!-- {{ maxYear }} -->
                            </v-col>
                        </v-row>
                        <v-row dense>
                            <v-col class="mb-4" cols="4">
                                <h3>Inputs</h3>
                                <v-checkbox v-for="input in inputs" :label="input" :value="input" density="compact"
                                    v-model="selectedInput" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4">
                                <h3>Outputs</h3>
                                <v-checkbox v-for="output in outputs" :label="output" :value="output" density="compact"
                                    v-model="selectedOutputs" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4">
                                <h3>Display technologies</h3>
                                <v-checkbox v-for="devTech in delivTechnologies" :label="devTech" :value="devTech"
                                    density="compact" v-model="selectedDevTech" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4">
                                <h3>Input technologies</h3>
                                <v-checkbox v-for="recepTech in recepTechnologies" :label="recepTech" :value="recepTech"
                                    density="compact" v-model="selectedRecepTech" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4">
                                <h3>Objects</h3>
                                <v-checkbox v-for="object in objects" :label="object" :value="object" density="compact"
                                    v-model="selectedObject" hide-details></v-checkbox>
                            </v-col>
                            <v-col class="mb-4" cols="4">
                                <h3>Origins</h3>
                                <v-checkbox v-for="origin in origins" :label="origin" :value="origin" density="compact"
                                    v-model="selectedOrigin" hide-details></v-checkbox>
                            </v-col>

                        </v-row>
                    </v-card-text>
                </v-card>
            </v-col>
        </v-row>
    </v-container>
</template>

<script setup>
import { onMounted, ref, computed, watch } from 'vue';
import { Bar , Line } from 'vue-chartjs'
import data from '@/assets/dataTUI-v2.json';
import { useDisplay } from 'vuetify'
import { Chart as ChartJS, Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale, LineElement, PointElement} from 'chart.js'

// Destructure only the keys you want to use
const { smAndDown, mdAndUp } = useDisplay()

// Enregistrement des composants Chart.js
ChartJS.register(Title, Tooltip, Legend, BarElement, CategoryScale, LinearScale, LineElement, PointElement)

// Constantes
const inputs = ['Free', 'Binary', 'Linear', 'Rotational','Non Linear'];
const outputs = ['Visual', 'Audio', 'Haptic'];
const origins = ['Academic', 'Industry', 'Hobbyist'];
const delivTechnologies = ['Wearables', 'Projection', 'Handheld object', 'Overlay AR'];
const recepTechnologies = ['Computer Vision', 'Microcontrollers, Sensors, and Actuators', 'RFID'];
const objects = ['Geometric', 'Organic', 'Controller', 'Display', 'Shape retaining', 'Non shape retaining'];

// Variables réactives
const cards = ref(data)
const inputsChartKey = ref(0) // Pour forcer le re-render du graphique
const outputsChartKey = ref(0)
const objectsChartKey = ref(0)
const inputsTechChartKey = ref(0)
const displayTechChartKey = ref(0)
const timelineChartKey = ref(0) 

// Filtres
const selectedYears = ref([1950, 2030])
const filterPanelOpened = ref(true)
const selectedInput = ref([...inputs]) // Tous sélectionnés par défaut
const selectedOutputs = ref([...outputs]) // Tous sélectionnés par défaut
const selectedDevTech = ref([...delivTechnologies])
const selectedRecepTech = ref([...recepTechnologies])
const selectedObject = ref([...objects])
const selectedOrigin = ref([...origins])

// Calculs des min/max années
const minYear = computed(() => {
    const validYears = cards.value
        .filter(card => typeof card.year === 'number' && card.year > 0)
        .map(card => card.year);
    return validYears.length > 0 ? Math.min(...validYears) : 1950;
});

const maxYear = computed(() => {
    const validYears = cards.value
        .filter(card => typeof card.year === 'number' && card.year > 0)
        .map(card => card.year);
    return validYears.length > 0 ? Math.max(...validYears) : 2030;
});

// Chaîne de filtres
const yearFilteredCards = computed(() => {
    return cards.value.filter(card => {
        const year = card.year || 0;
        return year >= selectedYears.value[0] && year <= selectedYears.value[1];
    });
});

const inputFilteredCards = computed(() => {
    return yearFilteredCards.value.filter(card => {
        if (!card.input || !Array.isArray(card.input)) return false;
        return card.input.some(input => selectedInput.value.includes(input));
    });
});

const outputfilteredCards = computed(() => {
    return inputFilteredCards.value.filter(card => {
        if (!card.output || !Array.isArray(card.output)) return false;
        return card.output.some(output => selectedOutputs.value.includes(output));
    });
});

const delivTechfilteredCards = computed(() => {
    return outputfilteredCards.value.filter(card => {
        if (!card.delivery_technology || !Array.isArray(card.delivery_technology)) return false;
        return card.delivery_technology.some(delivTech => selectedDevTech.value.includes(delivTech));
    });
});

const recepTechfilteredCards = computed(() => {
    return delivTechfilteredCards.value.filter(card => {
        if (!card.reception_technology || !Array.isArray(card.reception_technology)) return false;
        return card.reception_technology.some(recepTech => selectedRecepTech.value.includes(recepTech));
    });
});

const filteredCards = computed(() => {
    return recepTechfilteredCards.value.filter(card => {
        if (!card.object || !Array.isArray(card.object)) return false;
        return card.object.some(obj => selectedObject.value.includes(obj));
    });
});


// Calcul des données du graphique
const timelineCounts = computed(() => {
    const counts = {};
    
    // Initialiser tous les compteurs à 0 pour la plage d'années sélectionnée
    for (let year = selectedYears.value[0]; year <= selectedYears.value[1]; year++) {
        counts[year] = 0;
    }
    
    // Compter les systèmes par année dans les données filtrées
    filteredCards.value.forEach(system => {
        const year = system.year;
        if (year && typeof year === 'number' && year >= selectedYears.value[0] && year <= selectedYears.value[1]) {
            counts[year] = (counts[year] || 0) + 1;
        }
    });
    
    return counts;
});

const inputCounts = computed(() => {
    const counts = {};

    // Initialiser les compteurs
    inputs.forEach(input => {
        counts[input] = 0;
    });

    // Compter les occurrences dans les données filtrées
    filteredCards.value.forEach(system => {
        if (system.input && Array.isArray(system.input)) {
            system.input.forEach(item => {
                if (counts.hasOwnProperty(item)) {
                    counts[item] += 1;
                }
            });
        }
    });

    return counts;
});

const outputCounts = computed(() => {
    const counts = {};

    // Initialiser les compteurs
    outputs.forEach(output => {
        counts[output] = 0;
    });

    // Compter les occurrences dans les données filtrées
    filteredCards.value.forEach(system => {
        if (system.output && Array.isArray(system.output)) {
            system.output.forEach(item => {
                if (counts.hasOwnProperty(item)) {
                    counts[item] += 1;
                }
            });
        }
    });

    return counts;
});

const objectsCounts = computed(() => {
    const counts = {};

    // Initialiser les compteurs
    objects.forEach(object => {
        counts[object] = 0;
    });

    // Compter les occurrences dans les données filtrées
    filteredCards.value.forEach(system => {
        if (system.object && Array.isArray(system.object)) {
            system.object.forEach(item => {
                if (counts.hasOwnProperty(item)) {
                    counts[item] += 1;
                }
            });
        }
    });

    return counts;
});

const displayTechCounts = computed(() => {
    const counts = {};

    // Initialiser les compteurs
    delivTechnologies.forEach(inputTech => {
        counts[inputTech] = 0;
    });

    // Compter les occurrences dans les données filtrées
    filteredCards.value.forEach(system => {
        if (system.delivery_technology && Array.isArray(system.delivery_technology)) {
            system.delivery_technology.forEach(item => {
                if (counts.hasOwnProperty(item)) {
                    counts[item] += 1;
                }
            });
        }
    });

    return counts;
});

const inputTechCounts = computed(() => {
    const counts = {};

    // Initialiser les compteurs
    recepTechnologies.forEach(inputTech => {
        counts[inputTech] = 0;
    });

    // Compter les occurrences dans les données filtrées
    filteredCards.value.forEach(system => {
        if (system.reception_technology && Array.isArray(system.reception_technology)) {
            system.reception_technology.forEach(item => {
                if (counts.hasOwnProperty(item)) {
                    counts[item] += 1;
                }
            });
        }
    });

    return counts;
});

// Configuration du graphique
const timelineChartData = computed(() => {
    const years = Object.keys(timelineCounts.value).map(Number).sort();
    const data = years.map(year => timelineCounts.value[year]);
    
    return {
        labels: years,
        datasets: [
            {
                label: 'Number of TUI Systems',
                data: data,
                borderColor: '#36A2EB',
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderWidth: 2,
                fill: true,
                tension: 0.1
            }
        ]
    };
});

const timelineChartOptions = ref({
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
        title: {
            display: false,
            text: 'TUI Systems Timeline'
        },
        legend: {
            display: true,
            position: 'top'
        },
        tooltip: {
            callbacks: {
                title: function (context) {
                    return `Year: ${context[0].label}`;
                },
                label: function (context) {
                    return `${context.raw} systems published`;
                }
            }
        }
    },
    scales: {
        x: {
            title: {
                display: true,
                text: 'Year'
            },
            type: 'linear',
            position: 'bottom'
        },
        y: {
            beginAtZero: true,
            title: {
                display: true,
                text: 'Number of Systems'
            },
            ticks: {
                stepSize: 1
            }
        }
    },
    interaction: {
        intersect: false,
        mode: 'index'
    }
});


const inputChartData = computed(() => ({
    labels: inputs,
    datasets: [
        {
            label: 'Number of occurrences',
            backgroundColor: [
                '#FF6384',
                '#36A2EB',
                '#FFCE56',
                '#FFCE56',
                '#FFCE56'
            ],
            borderColor: [
                '#FF6384',
                '#36A2EB',
                '#FFCE56',
                '#FFCE56',
                '#FFCE56'
            ],
            borderWidth: 1,
            data: Object.values(inputCounts.value)
        }
    ]
}));

const inputsChartOptions = ref({
    responsive: true,
    maintainAspectRatio: false,
    indexAxis: 'y', // Graphique horizontal
    plugins: {
        title: {
            display: false,
            text: 'Distribution of inputs types'
        },
        legend: {
            display: false
        },
        tooltip: {
            callbacks: {
                title: function (context) {
                    return context[0].label;
                },
                label: function (context) {
                    const total = Object.values(inputCounts.value).reduce((a, b) => a + b, 0);
                    const percentage = total > 0 ? ((context.raw / total) * 100).toFixed(1) : 0;
                    return `${context.raw} occurrences (${percentage}%)`;
                }
            }
        }
    },
    scales: {
        x: {
            beginAtZero: true,
            title: {
                display: true,
                text: 'Number of occurrences'
            }
        },
        y: {
            title: {
                display: true,
                text: 'Input Type'
            }
        }
    }
});

const outputChartData = computed(() => ({
    labels: outputs,
    datasets: [
        {
            label: 'Nombre of occurrences',
            backgroundColor: [
                '#36A2EB',
                '#36A2EB',
                '#36A2EB'
            ],
            borderColor: [
                '#36A2EB',
                '#36A2EB',
                '#36A2EB'
            ],
            borderWidth: 1,
            data: Object.values(outputCounts.value)
        }
    ]
}));

const outputsChartOptions = ref({
    responsive: true,
    maintainAspectRatio: false,
    indexAxis: 'y', // Graphique horizontal
    plugins: {
        title: {
            display: false,
            text: 'Distribution of Output Types'
        },
        legend: {
            display: false
        },
        tooltip: {
            callbacks: {
                title: function (context) {
                    return context[0].label;
                },
                label: function (context) {
                    const total = Object.values(outputCounts.value).reduce((a, b) => a + b, 0);
                    const percentage = total > 0 ? ((context.raw / total) * 100).toFixed(1) : 0;
                    return `${context.raw} occurrences (${percentage}%)`;
                }
            }
        }
    },
    scales: {
        x: {
            beginAtZero: true,
            title: {
                display: true,
                text: 'Number of occurrences'
            }
        },
        y: {
            title: {
                display: true,
                text: 'Output Types '
            }
        }
    }
});

const objectsChartData = computed(() => ({
    labels: objects,
    datasets: [
        {
            label: 'Nombre of occurrences',
            backgroundColor: [
                '#FF6384',
                '#FF6384',
                '#36A2EB',
                '#36A2EB',
                '#FFCE56',
                '#FFCE56'
            ],
            borderColor: [
                '#FF6384',
                '#FF6384',
                '#36A2EB',
                '#36A2EB',
                '#FFCE56',
                '#FFCE56'
            ],
            borderWidth: 1,
            data: Object.values(objectsCounts.value)
        }
    ]
}));

const objectsChartOptions = ref({
    responsive: true,
    maintainAspectRatio: false,
    indexAxis: 'y', // Graphique horizontal
    plugins: {
        title: {
            display: false,
            text: 'Distribution of Objects Characteristics'
        },
        legend: {
            display: false
        },
        tooltip: {
            callbacks: {
                title: function (context) {
                    return context[0].label;
                },
                label: function (context) {
                    const total = Object.values(objectsCounts.value).reduce((a, b) => a + b, 0);
                    const percentage = total > 0 ? ((context.raw / total) * 100).toFixed(1) : 0;
                    return `${context.raw} occurrences (${percentage}%)`;
                }
            }
        }
    },
    scales: {
        x: {
            beginAtZero: true,
            title: {
                display: true,
                text: 'Number of occurrences'
            }
        },
        y: {
            title: {
                display: true,
                text: 'Objects Characteristics'
            }
        }
    }
});

const inputsTechChartData = computed(() => ({
    labels: recepTechnologies,
    datasets: [
        {
            label: 'Nombre of occurrences',
            backgroundColor: [
                '#36A2EB',
            ],
            borderColor: [
                '#36A2EB'
            ],
            borderWidth: 1,
            data: Object.values(inputTechCounts.value)
        }
    ]
}));

const inputsTechChartOptions = ref({
    responsive: true,
    maintainAspectRatio: false,
    indexAxis: 'y', // Graphique horizontal
    plugins: {
        title: {
            display: false,
            text: 'Distribution of Input Technologies'
        },
        legend: {
            display: false
        },
        tooltip: {
            callbacks: {
                title: function (context) {
                    return context[0].label;
                },
                label: function (context) {
                    const total = Object.values(inputTechCounts.value).reduce((a, b) => a + b, 0);
                    const percentage = total > 0 ? ((context.raw / total) * 100).toFixed(1) : 0;
                    return `${context.raw} occurrences (${percentage}%)`;
                }
            }
        }
    },
    scales: {
        x: {
            beginAtZero: true,
            title: {
                display: true,
                text: 'Number of occurrences'
            }
        },
        y: {
            title: {
                display: true,
                text: 'Input Technologies'
            }
        }
    }
});

const displayTechChartData = computed(() => ({
    labels: delivTechnologies,
    datasets: [
        {
            label: 'Nombre of occurrences',
            backgroundColor: [
                '#36A2EB',
            ],
            borderColor: [
                '#36A2EB',
            ],
            borderWidth: 1,
            data: Object.values(displayTechCounts.value)
        }
    ]
}));

const displayTechChartOptions = ref({
    responsive: true,
    maintainAspectRatio: false,
    indexAxis: 'y', // Graphique horizontal
    plugins: {
        title: {
            display: false,
            text: 'Distribution of Display Technologies'
        },
        legend: {
            display: false
        },
        tooltip: {
            callbacks: {
                title: function (context) {
                    return context[0].label;
                },
                label: function (context) {
                    const total = Object.values(displayTechCounts.value).reduce((a, b) => a + b, 0);
                    const percentage = total > 0 ? ((context.raw / total) * 100).toFixed(1) : 0;
                    return `${context.raw} occurrences (${percentage}%)`;
                }
            }
        }
    },
    scales: {
        x: {
            beginAtZero: true,
            title: {
                display: true,
                text: 'Number of occurrences'
            }
        },
        y: {
            title: {
                display: true,
                text: 'Display Technologies'
            }
        }
    }
});

// Functions
function removeFilter() {
    selectedInput.value = [...inputs];
    selectedOutputs.value = [...outputs];
    selectedDevTech.value = [...delivTechnologies];
    selectedRecepTech.value = [...recepTechnologies];
    selectedObject.value = [...objects];
    selectedOrigin.value = [...origins];
    selectedYears.value = [minYear.value, maxYear.value];
}

// Watcher pour forcer le re-render du graphique quand les données changent
watch([inputCounts], () => {
    inputsChartKey.value += 1;
}, { deep: true });

watch([outputCounts], () => {
    outputsChartKey.value += 1;
}, { deep: true });

watch([objectsCounts], () => {
    objectsChartKey.value += 1;
}, { deep: true });

watch([inputTechCounts], () => {
    inputsTechChartKey.value += 1;
}, { deep: true });

watch([displayTechCounts], () => {
    displayTechChartKey.value += 1;
}, { deep: true });

watch([timelineCounts], () => {
    timelineChartKey.value += 1;
}, { deep: true });

// Initialisation
onMounted(() => {
    selectedYears.value = [minYear.value, maxYear.value];
});
</script>

<style scoped>
.full-height {
    min-height: calc(100vh - 64px);
}
</style>