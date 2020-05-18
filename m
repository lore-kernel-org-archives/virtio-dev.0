Return-Path: virtio-comment-return-1261-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: David Hildenbrand <david@redhat.com>
References: <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
 <158956398852.246123.13563550180731658368.stgit@ahduyck-workstation>
 <7558cc20-262b-ddc4-2442-e05f0b74b59d@redhat.com>
Message-ID: <2e5d34df-5c76-23a8-95c9-2f4556ac8ef7@redhat.com>
Date: Mon, 18 May 2020 15:20:54 +0200
MIME-Version: 1.0
In-Reply-To: <7558cc20-262b-ddc4-2442-e05f0b74b59d@redhat.com>
Content-Language: en-US
Subject: Re: [virtio-comment] [PATCH v2 1/3] content: Document balloon feature
 free page hints
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


>> +
>> +\devicenormative{\paragraph}{Free Page Hinting}{Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
>> +
>> +Normative statements in this section apply if the
>> +VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.
>> +
>> +The device MUST set \field{free_page_hint_cmd_id} to
>> +VIRTIO_BALLOON_CMD_ID_STOP any time that the dirty pages for the given
>> +guest are being recorded.
>> +
>> +The device MUST NOT reuse a command ID until it has received an output
>> +descriptor containing VIRTIO_BALLOON_CMD_ID_STOP from the driver.
>> +
>> +The device MUST ignore pages that are provided with a command ID that does
>> +not match the current value in \field{free_page_hint_cmd_id}.
>> +
>> +The device MAY modify the contents of the page in the balloon if the page
>> +has not been modified by the guest since the \field{free_page_hint_cmd_id}
>> +associated with the hint was issued by the device.
> 
> "page in the balloon" -> "previously hinted pages"
> 
> But it's not that easy in respect to the guest reusing the pages.
> 
> "previously hinted pages and not reused pages" ?
> 
> Also, something like
> 
> "The device MUST NOT modify the contents of previously hinted pages in
> case they are reused by the devices, even if they are reused by the
> driver before the hinting request is processed."

"reused by the driver" in the first instance of course.


-- 
Thanks,

David / dhildenb


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

