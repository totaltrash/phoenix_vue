<template>
  <div class="bg-white py-3 flex items-center justify-between px-4 sm:px-6" data-role="paginator">
    <div class="md:flex-1 md:flex md:items-center md:justify-between md:gap-4">
      <div class="hidden md:block">
        <p class="text-sm text-gray-700">
          Showing <span class="font-medium">
            {{ recordRangeStart }}
          </span> to <span class="font-medium">
            {{ recordRangeEnd }}
          </span> of <span class="font-medium">
            {{ count }}
          </span> results
          <!--
          (page: {{ page }}, range: {{ range }}, pageCount: {{ pageCount }}, previousPages: {{ previousPages }},
          nextPages: {{ nextPages }})
          -->
        </p>
      </div>
      <div>
        <nav class="inline-flex shadow-sm -space-x-px h-9" aria-label="Pagination">
          <PaginatorItem @click="(p) => changePage(p)" :icon="ChevronDoubleLeftIcon" :page="1" :enabled="page !== 1" />
          <PaginatorItem @click="(p) => changePage(p)" :icon="ChevronLeftIcon" :page="Math.max(page - 1, 1)"
            :enabled="page !== 1" />
          <PaginatorItem v-if="showPreviousRange" :icon="DotsHorizontalIcon" hideOnMobile :enabled="false" />
          <PaginatorItem @click="(p) => changePage(p)" v-for="previousPage in previousPages" :page="previousPage"
            hideOnMobile />
          <PaginatorItem :page="page" selected />
          <PaginatorItem @click="(p) => changePage(p)" v-for="nextPage in nextPages" :page="nextPage" hideOnMobile />
          <PaginatorItem v-if="showNextRange" :icon="DotsHorizontalIcon" hideOnMobile :enabled="false" />
          <PaginatorItem @click="(p) => changePage(p)" :icon="ChevronRightIcon" :page="Math.min(page + 1, pageCount)"
            :enabled="page !== pageCount" />
          <PaginatorItem @click="(p) => changePage(p)" :icon="ChevronDoubleRightIcon" :page="pageCount"
            :enabled="page !== pageCount" />
        </nav>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'
import PaginatorItem from '~/components/paginator/PaginatorItem.vue'
import { DotsHorizontalIcon, ChevronDoubleLeftIcon, ChevronLeftIcon, ChevronDoubleRightIcon, ChevronRightIcon } from '@heroicons/vue/solid'

const props = defineProps({
  count: {
    type: Number,
    required: true,
  },
  offset: {
    type: Number,
    required: true,
  },
  limit: {
    type: Number,
    required: true,
  },
  range: {
    type: Number,
    required: false,
    default: 3,
  }
})

const page = computed(() => {
  return Math.floor((props.offset + props.limit) / props.limit)
})

const recordRangeStart = computed(() => {
  return Math.min(props.offset + 1, props.count)
})

const recordRangeEnd = computed(() => {
  return Math.min(props.offset + props.limit, props.count)
})

const pageCount = computed(() => {
  if (props.count === 0) {
    return 1
  }
  if (props.count % props.limit > 0) {
    return Math.floor(props.count / props.limit) + 1
  }
  return Math.floor(props.count / props.limit)
})

const showPreviousRange = computed(() => page.value - 1 > props.range)
const showNextRange = computed(() => page.value + props.range < pageCount.value)

function numberRange(start, end) {
  return new Array(end - start + 1).fill().map((d, i) => i + start)
}

const nextPages = computed(() => {
  return numberRange(page.value + 1, page.value + props.range).filter((p) => p <= pageCount.value)
})

const previousPages = computed(() => {
  return numberRange(page.value - props.range, page.value - 1).filter((p) => p > 0)
})

const emit = defineEmits(['change'])

function changePage(p) {
  const offset = (p - 1) * props.limit
  emit('change', offset)
}

</script>
