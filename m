Return-Path: virtio-comment-return-1309-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <159055235065.209072.12017445428967301686.stgit@ahduyck-workstation>
 <159055240999.209072.325801657165111674.stgit@ahduyck-workstation>
 <1fc7b0ba-4af8-8161-d683-a28e9502a70a@redhat.com>
 <CAKgT0UcXr5MzeCRxBpf-+DCXDF3QHT-c21msQOU49Mygv5gmWg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e62da272-de13-2bce-a00a-7e6871a9dd76@redhat.com>
Date: Fri, 29 May 2020 19:15:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcXr5MzeCRxBpf-+DCXDF3QHT-c21msQOU49Mygv5gmWg@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-comment] [PATCH v4 1/3] content: Document balloon feature
 page poison
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 29.05.20 18:57, Alexander Duyck wrote:
> On Fri, May 29, 2020 at 1:13 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 27.05.20 06:06, Alexander Duyck wrote:
>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>
>>> Page poison provides a way for the guest to notify the host that it is
>>> initializing or poisoning freed pages with some specific poison value. As a
>>> result of this we can infer a couple traits about the guest:
>>>
>>> 1. Free pages will contain a specific pattern within the guest.
>>> 2. Modifying free pages from this value may cause an error in the guest.
>>> 3. Pages will be immediately written to by the driver when deflated.
>>>
>>> There are currently no existing features that make use of this data. In the
>>> upcoming feature free page reporting we will need to make use of this to
>>> identify if we can evict pages from the guest without causing data
>>> corruption.
>>>
>>> Add documentation for the page poison feature describing the basic
>>> functionality and requirements.
>>>
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> ---
>>>  conformance.tex |    2 ++
>>>  content.tex     |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>>>  2 files changed, 57 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/conformance.tex b/conformance.tex
>>> index b6fdec090383..4ed9d62e8088 100644
>>> --- a/conformance.tex
>>> +++ b/conformance.tex
>>> @@ -149,6 +149,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>>  \item \ref{drivernormative:Device Types / Memory Balloon Device / Feature bits}
>>>  \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation}
>>>  \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
>>> +\item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Page Poison}
>>>  \end{itemize}
>>>
>>>  \conformance{\subsection}{SCSI Host Driver Conformance}\label{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}
>>> @@ -331,6 +332,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>>>  \item \ref{devicenormative:Device Types / Memory Balloon Device / Feature bits}
>>>  \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation}
>>>  \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
>>> +\item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Page Poison}
>>>  \end{itemize}
>>>
>>>  \conformance{\subsection}{SCSI Host Device Conformance}\label{sec:Conformance / Device Conformance / SCSI Host Device Conformance}
>>> diff --git a/content.tex b/content.tex
>>> index 91735e3eb018..4a0ab90260ff 100644
>>> --- a/content.tex
>>> +++ b/content.tex
>>> @@ -5019,6 +5019,9 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
>>>      memory statistics is present.
>>>  \item[VIRTIO_BALLOON_F_DEFLATE_ON_OOM (2) ] Deflate balloon on
>>>      guest out of memory condition.
>>> +\item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] A hint to the device, that the driver
>>> +    will immediately write \field{poison_val} to pages after deflating them.
>>> +    Configuration field \field{poison_val} is valid.
>>>
>>
>> Here we have "that the driver will immediately" ...
>>
>> But we never document that in form of a normative statement (e.g., "The
>> driver MUST initialize pages with \field{poison_val} after deflating").
> 
> I'm pretty sure we did document that. In the normative statement for
> the driver below we have:
> +The driver MUST initialize the deflated pages with \field{poison_val} when
> +they are reused by the driver.
> 

Doh! I think I missed that somehow

Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

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

