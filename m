Return-Path: virtio-dev-return-6981-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85D8298601F
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Mar 2020 11:20:16 +0000 (UTC)
References: <20200323133831.2110014-1-jean-philippe@linaro.org>
 <55f19d89-ff7b-b3f6-d5f8-c2b31c23a38a@redhat.com>
 <20200326104933.GA2639913@myrica>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ac83718d-729d-84b4-93f4-43bde6256068@redhat.com>
Date: Thu, 26 Mar 2020 12:20:06 +0100
MIME-Version: 1.0
In-Reply-To: <20200326104933.GA2639913@myrica>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [RFC PATCH] virtio-iommu: Add PAGE_SIZE_MASK
 property
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, bbhushan2@marvell.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Jean,

On 3/26/20 11:49 AM, Jean-Philippe Brucker wrote:
> On Mon, Mar 23, 2020 at 03:22:40PM +0100, Auger Eric wrote:
>> Hi Jean,
>>
>> On 3/23/20 2:38 PM, Jean-Philippe Brucker wrote:
>>> Add a PROBE property to declare the mapping granularity per endpoint.
>>> The virtio-iommu device already declares a granule in its config space,
>>> but when endpoints are behind different physical IOMMUs, they may have
>>> different mapping granules. This new property allows to override the
>>> global page_size_mask for each endpoint.
>>>
>>> In the future it may be useful to describe more than one page_size_mask
>>> for each endpoint, and allow them to negotiate it during ATTACH. For
>>> example two masks could allow the driver to choose between 4k and 64k
>>> granule, along with their respective block mapping sizes. This could be
>>> added by replacing \field{reserved} with an array length, for example.
>> Sorry I don't get the use case where several page size bitmaps should be
>> exposed.
> 
> For a 4k granule you get block mappings of 2M and 1G. For a 64k granule
> you get 512M and 4T block mappings. If you want to communicate both
> options to the guest, you need two separate masks, 0x40201000 and
> 0x40020010000. Then the guest could choose one of the granules during
> attach, if we add a flag to the attach request. I'm not suggesting we do
> that now, just trying to make sure it can be extended if anyone actually
> wants it. Personally I don't think it's worth adding, especially given the
> additional work required in the host.
OK I get it now.
> 
>>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> ---
>>> I had this change planned for a page-table sharing extension, but it
>>> seems to be useful for the VFIO support in QEMU as well [1].
>>>
>>> [1] https://lore.kernel.org/qemu-devel/3da60c1b-6897-7ab1-3a67-bec44fa00a54@redhat.com/
>>> ---
>>> ---
>>>  virtio-iommu.tex | 33 ++++++++++++++++++++++++++++++++-
>>>  1 file changed, 32 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/virtio-iommu.tex b/virtio-iommu.tex
>>> index 08b358a..d7be13d 100644
>>> --- a/virtio-iommu.tex
>>> +++ b/virtio-iommu.tex
>>> @@ -664,7 +664,8 @@ \subsubsection{PROBE request}\label{sec:Device Types / IOMMU Device / Device ope
>>>  \subsubsection{PROBE properties}\label{sec:Device Types / IOMMU Device / Device operations / PROBE properties}
>>>  
>>>  \begin{lstlisting}
>>> -#define VIRTIO_IOMMU_PROBE_T_RESV_MEM   1
>>> +#define VIRTIO_IOMMU_PROBE_T_RESV_MEM         1
>>> +#define VIRTIO_IOMMU_PROBE_T_PAGE_SIZE_MASK   2
>>>  \end{lstlisting}
>>>  
>>>  \paragraph{Property RESV_MEM}\label{sec:Device Types / IOMMU Device / Device operations / PROBE properties / RESVMEM}
>>> @@ -727,6 +728,36 @@ \subsubsection{PROBE properties}\label{sec:Device Types / IOMMU Device / Device
>>>  The device SHOULD NOT allow accesses from the endpoint to RESV_MEM regions
>>>  to affect any other component than the endpoint and the driver.
>>>  
>>> +\paragraph{Property PAGE_SIZE_MASK}\label{sec:Device Types / IOMMU Device / Device operations / PROBE properties / PAGESIZEMASK}
>> "Property PAGESIZEMASK" to be homegeneous with "Property RESV_MEM"?>
> I don't understand, isn't the underscore version more homogeneous? I only
> used PAGESIZEMASK and RESVMEM in the label to avoid troubles with latex,
> which complains about underscores in labels (maybe because of the
> underscore package). But labels are only used for resolving references and
> don't appear in the final text.
Sorry, I thought the paragraph title was PAGESIZEMASK instead of
"Property PAGE_SIZE_MASK" but I misread the description. Forgive me for
the noise.
> 
>>> +
>>> +The PAGE_SIZE_MASK property overrides the global \field{page_size_mask}
>>> +configuration for an endpoint.
>>> +
>>> +\begin{lstlisting}
>>> +struct virtio_iommu_probe_page_size_mask {
>>> +  struct virtio_iommu_probe_property head;
>>> +  u8    reserved[4];
>>> +  le64  page_size_mask;
>>> +};
>>> +\end{lstlisting}
>>
>> Maybe it would be useful to put in the spec the context of use of the
>> new property (basically what you wrote in the commit msg). Also
>> re-inforce that if no ep page size mask is returned the default one
>> applies. Chapters describing page_size_mask global field may be sligtly
>> augmented to mention the new prop...
> 
> I'll add that if no page size mask property is present, the global page
> size mask applies. And in Device operations I'll add that these limits are
> described in the device configuration as well as probe properties.
OK

Thanks

Eric
> 
> Thanks,
> Jean
> 
>>> +
>>> +The \field{page_size_mask} field behaves in the same way as the global
>>> +\field{page_size_mask} field. The least significant bit describes the
>>> +mapping granularity, and additional bits are hints (see \ref{sec:Device
>>> +Types / IOMMU Device / Device operations})
>>> +
>>> +\drivernormative{\subparagraph}{Property PAGE_SIZE_MASK}{Device Types / IOMMU Device / Device operations / PROBE properties / PAGESIZEMASK}
>>> +
>>> +The driver MUST ignore \field{reserved}.
>>> +
>>> +\devicenormative{\subparagraph}{Property PAGE_SIZE_MASK}{Device Types / IOMMU Device / Device operations / PROBE properties / PAGESIZEMASK}
>>> +
>>> +The device SHOULD set \field{reserved} to zero.
>>> +
>>> +The device MUST set at least one bit in \field{page_size_mask}, describing
>>> +the page granularity. The device MAY set more than one bit in
>>> +\field{page_size_mask}.
>>> +
>>>  \subsubsection{Fault reporting}\label{sev:Device Types / IOMMU Device / Device operations / Fault reporting}
>>>  
>>>  The device can report translation faults and other significant
>>>
>>
>> Thanks
>>
>> Eric
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

