Return-Path: <eric.auger@redhat.com>
Reply-To: eric.auger@redhat.com
Subject: Re: [virtio-dev] [PATCH] virtio-iommu: Rework the bypass feature
References: <20210930163503.51200-1-jean-philippe@linaro.org>
 <1f6db67d-03fd-7d12-8c99-7e1eab6db99b@redhat.com> <YV8yWHwgOvYw9Fn2@myrica>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <1e49b265-85c3-aeda-dd8b-e584413c2ed6@redhat.com>
Date: Sun, 31 Oct 2021 16:50:37 +0100
MIME-Version: 1.0
In-Reply-To: <YV8yWHwgOvYw9Fn2@myrica>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, sebastien.boeuf@intel.com, kevin.tian@intel.com, cohuck@redhat.com, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Jean,

On 10/7/21 7:46 PM, Jean-Philippe Brucker wrote:
> Hi Eric,
>
> On Wed, Oct 06, 2021 at 02:53:50PM +0200, Eric Auger wrote:
>>> * The hypervisor can start the VM with bypass enabled or, if it knows
>>>   that the software stack supports it, disabled. The 'bypass' config
>>>   fields resets to 0 or 1.
>> I don't see the reset value documented in the actual spec while it looks
>> quite important for our boot bypass functionality. Or did I miss it?
> No you're right, I'll add this. It's important to say that the device may
> initialize the field to 1, but also that a reset (writing a 0 to device
> status) doesn't re-initialize the field to its boot value (because that
> may introduce a vulnerability during the FW->OS transition)
>
>   If the device offers the VIRTIO_IOMMU_F_BYPASS_CONFIG feature, it MAY
>   initialize the \field{bypass} field to 1. When the driver resets the
>   device, the \field{bypass} field SHOULD NOT change.
>
> [...]
>>> diff --git a/virtio-iommu.tex b/virtio-iommu.tex
>>> index efa735b..a2c90ea 100644
>>> --- a/virtio-iommu.tex
>>> +++ b/virtio-iommu.tex
>>> @@ -59,14 +59,19 @@ \subsection{Feature bits}\label{sec:Device Types / IOMMU Device / Feature bits}
>>>    VIRTIO_IOMMU_F_MAP_UNMAP is supported.}
>>>  
>>>  \item[VIRTIO_IOMMU_F_BYPASS (3)]
>>> -  When not attached to a domain, endpoints downstream of the IOMMU
>>> -  can access the guest-physical address space.
>>> +  This feature is deprecated.
>> Why are you obliged to deprecate the feature.
> We could leave the feature, but it adds complexity in the spec, and in
> drivers if they have to support both. Maybe we can leave the feature,
> merge its description with F_BYPASS_CONFIG and state something like:
>
>   The VIRTIO_IOMMU_F_BYPASS_CONFIG feature supersedes
>   VIRTIO_IOMMU_F_BYPASS. New devices SHOULD NOT offer
>   VIRTIO_IOMMU_F_BYPASS.
>
>> Can't you leave it and
>> impose that either
>>
>> VIRTIO_IOMMU_F_BYPASS or VIRTIO_IOMMU_F_BYPASS_CONFIG gets set?
> Just to be clear, you mean devices must not implement both features at the
> same time, right? 

Yes that's what I meant.
>  Not that devices must implement at least one of the
> feature? (I don't think we can do that)
>
>>>  
>>>  \item[VIRTIO_IOMMU_F_PROBE (4)]
>>>    The PROBE request is available.
>>>  
>>>  \item[VIRTIO_IOMMU_F_MMIO (5)]
>>>    The VIRTIO_IOMMU_MAP_F_MMIO flag is available.
>>> +
>>> +\item[VIRTIO_IOMMU_F_BYPASS_CONFIG (6)]
>>> +  The global bypass state is described in \field{bypass} of
>>> +  struct virtio_iommu_config. The domain bypass state is
>>> +  described by VIRTIO_IOMMU_ATTACH_F_BYPASS.
>> I would re-emphasize the global bypass state relates to bypass state of
>> unattached devices whereas domain bypass state controls bypass for
>> devices attached to a given domain.
> Right, though I think I'll drop "bypass state" and describe everything
> using "endpoint in bypass mode", so we can keep a single definition in one
> place.
>
> [...]
>>>  \subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Device initialization}
>>>  
>>>  When the device is reset, endpoints are not attached to any domain.
>>>  
>>> -If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, all accesses from
>>> -unattached endpoints are allowed and translated by the IOMMU using the
>>> -identity function. If the feature is not negotiated, any memory access
>>> -from an unattached endpoint fails. Upon attaching an endpoint in
>>> -bypass mode to a new domain, any memory access from the endpoint fails,
>>> -since the domain does not contain any mapping.
>>> +An endpoint is in bypass mode if the VIRTIO_IOMMU_F_BYPASS_CONFIG
>>> +feature is offered and:
>>> +\begin{itemize}
>>> +  \item config field \field{bypass} is 1 and the endpoint is not
>>> +    attached to a domain, or
>>> +  \item the endpoint is attached to a domain with
>>> +    VIRTIO_IOMMU_ATTACH_F_BYPASS.
>>> +\end{itemize}
>>> +
>>> +All accesses from an endpoint in bypass mode are allowed and
>>> +translated by the IOMMU using the identity function.
> I think I'll move this description to the Device operations section, not
> sure why it was here in the first place.
>
>>>  
>>>  Future devices might support more modes of operation besides MAP/UNMAP.
>>>  Drivers verify that devices set VIRTIO_IOMMU_F_MAP_UNMAP and fail
>>> @@ -136,8 +156,8 @@ \subsection{Device initialization}\label{sec:Device Types / IOMMU Device / Devic
>>>  
>>>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / IOMMU Device / Device Initialization}
>>>  
>>> -If the driver does not accept the VIRTIO_IOMMU_F_BYPASS feature, the
>>> -device SHOULD NOT let endpoints access the guest-physical address space.
>>> +The device SHOULD NOT let unattached endpoints that are not in
>>> +bypass mode access the guest-physical address space.
>> SHOULD NOT or MUST NOT. Can you remind me of the difference?
> They are defined in rfc2119 https://datatracker.ietf.org/doc/html/rfc2119
>
> SHOULD NOT
>   This phrase, or the phrase "NOT RECOMMENDED" mean that there may exist
>   valid reasons in particular circumstances when the particular behavior
>   is acceptable or even useful, but the full implications should be
>   understood and the case carefully weighed before implementing any
>   behavior described with this label.
>
> MUST NOT
>   This phrase, or the phrase "SHALL NOT", mean that the definition is an
>   absolute prohibition of the specification

Thank you for the reminder!
>
> So for this particular spec statement, I was reluctant to make it MUST
> because there may be cases where the unattached endpoint has to access
> some memory, even though I couldn't think of one. For example, maybe an
> endpoint that should not perform DMA could still be allowed to send MSIs?
>
> For the driver implementation, when the device has a "SHOULD NOT" and
> doesn't follow the rule I try to handle it more gracefully, than when it
> has a MUST NOT.

OK

Thanks

Eric
>
> [...]
>>>  Detach an endpoint from a domain. When this request completes, the
>>> -endpoint cannot access any mapping from that domain anymore. If feature
>>> -VIRTIO_IOMMU_F_BYPASS has been negotiated, then once this request
>>> -completes all accesses from the endpoint are allowed and translated by the
>>> -IOMMU using the identity function.
>>> +endpoint cannot access any mapping from that domain anymore.
>> You could adapt the rest of the paragraph to the new
>>
>> VIRTIO_IOMMU_F_BYPASS_CONFIG
>>
> I think the paragraph is redundant if we explain properly in "Device
> operations" how bypass works.
>
>>>  
>>>  After all endpoints have been successfully detached from a domain, it
>>>  ceases to exist and its ID can be reused by the driver for another domain.
>>> @@ -433,6 +466,8 @@ \subsubsection{MAP request}\label{sec:Device Types / IOMMU Device / Device opera
>>>  
>>>  The driver SHOULD set undefined \field{flags} bits to zero.
>>>  
>>> +The driver SHOULD NOT send MAP requests on a bypass domain.
>>> +
>>>  \field{virt_end} MUST be strictly greater than \field{virt_start}.
>>>  
>>>  The driver SHOULD set the VIRTIO_IOMMU_MAP_F_MMIO flag when the physical
>>> @@ -538,6 +573,8 @@ \subsubsection{UNMAP request}\label{sec:Device Types / IOMMU Device / Device ope
>>>  or be outside any mapping. The last address of a range MUST either be the
>>>  last address of a mapping or be outside any mapping.
>>>  
>>> +The driver SHOULD NOT send UNMAP requests on a bypass domain.
>>> +
>>>  \devicenormative{\paragraph}{UNMAP request}{Device Types / IOMMU Device / Device operations / UNMAP request}
>>>  
>>>  If the \field{reserved} field of an UNMAP request is not zero, the device
>> Shouldn't we descrive the behavior of the device is MAP/UNMAP is called
>> on a bypass domain or if we try to attach another device to a domain
>> with a different ATTACH_F_BYPASS flag?
> Ok
>
> Thanks,
> Jean
>

