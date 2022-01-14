Return-Path: <virtio-dev-return-9044-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3943F986507
	for <virtio-dev@lists.oasis-open.org>; Fri, 14 Jan 2022 03:23:09 +0000 (UTC)
Message-ID: <8feea104-4602-7cbc-9065-20b9dd66d7e3@redhat.com>
Date: Fri, 14 Jan 2022 11:23:00 +0800
MIME-Version: 1.0
References: <20220112055755.41011-1-jasowang@redhat.com>
 <20220112055755.41011-2-jasowang@redhat.com>
 <Yd6o/rFvyFFhR3+2@stefanha-x1.localdomain>
 <CACGkMEshBONdayoxYaA4LWY0_azztqW_2zAoe2tXCkJrLdoT+w@mail.gmail.com>
 <Yd/8t234EzNkz+9i@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <Yd/8t234EzNkz+9i@stefanha-x1.localdomain>
Subject: [virtio-dev] Re: [PATCH V2 1/2] virtio-pci: introduce virtio structure PCI
 Extended Capability
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


=E5=9C=A8 2022/1/13 =E4=B8=8B=E5=8D=886:19, Stefan Hajnoczi =E5=86=99=E9=81=
=93:
> On Thu, Jan 13, 2022 at 08:55:18AM +0800, Jason Wang wrote:
>> On Wed, Jan 12, 2022 at 6:10 PM Stefan Hajnoczi <stefanha@redhat.com> wr=
ote:
>>> On Wed, Jan 12, 2022 at 01:57:54PM +0800, Jason Wang wrote:
>>>> We're already out of the configuration space if there's a device that
>>>> supports all kinds of the virtio structure via PCI capability. This
>>>> prevents us from adding new capabilities in the future.
>>>>
>>>> So the patch adds the support for virtio structure via PCI Extended
>>>> Capability via the vendor specific extended capability.
>>>>
>>>> Only MMIO bar is allowed now.
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>> ---
>>>>   content.tex | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>>>>   1 file changed, 127 insertions(+)
>>>>
>>>> diff --git a/content.tex b/content.tex
>>>> index cf20570..00a75f2 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -1476,6 +1476,129 @@ \subsubsection{Non-transitional Device With Le=
gacy Driver: A Note
>>>>      of BAR0 by presenting zeroes on every BAR and ignoring writes.
>>>>   \end{enumerate}
>>>>
>>>> +\subsection{Virtio Structure PCI Extended Capabilities}\label{sec:Vir=
tio Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Extended=
 Capabilities}
>>>> +
>>>> +The location of the virtio structures that depend on the PCI Express
>>>> +capability are specified using a vendor-specific extended capabilitie=
s
>>>> +on the extended capabilities list in PCI Express extended
>>>> +configuration space of the device.
>>> I can't parse this sentence. Can you rephrase it and/or split it into
>>> multiple sentences?
>> Sure, how about something like:
>>
>> There could be virtio structures that depend on the PCI express
>> capability. The location of those structures are specified using a
>> vendor-specific extended capabilities on the extended capabilities
>> list.
> "virtio structures" -> "Virtio device configuration structures" (same as
> in "4.1.4 Virtio Structure PCI Capabilities")


Ok.


>
> "PCI express capability" -> "PCI Express Extended Capability" or did you
> mean that more generally (PCI Express features)?


More general PCI Express feature.


>
> Here is the edited sentence:
>
>    Virtio device configuration structures that depend on PCI Express
>    Extended Capabilities are specified using vendor-specific PCI Express
>    Extended Capabilities located on the PCI Express Extended Capabilities
>    list.


That's fine.


>>>> @@ -1488,6 +1611,10 @@ \subsubsection{Device Initialization}\label{sec=
:Virtio Transport Options / Virti
>>>>   PCI capability list, detecting virtio configuration layout using Vir=
tio
>>>>   Structure PCI capabilities as detailed in \ref{sec:Virtio Transport =
Options / Virtio Over PCI Bus / Virtio Structure PCI Capabilities}
>>>>
>>>> +Optionally, if the device is a PCIe device, the driver scans the PCI
>>>> +Extended capability list, detecting virtio configuration layout using
>>>> +Virtio Struct PCI Extended capabilities as detailed in \ref{sec:Virti=
o Transport Options / Virtio Over PCI Bus / Virtio Structure PCI Extended C=
apabilities}
>>> If the same structure is present in both the PCI Capabilities and PCI
>>> Extended Capabilities lists, which one has a higher priority?
>> This is not allowed in this proposal where only the structure that
>> depends on the PCI Express capability is allowed. E.g the PASID
>> configuration structure depends on the PASID extended capability.
>>
>> This is much more simpler than allowing existing virtio structures to
>> be presented on both PCI and PCIe capability list.
> Ah, I think I misunderstood the point of this patch. I thought you were
> defining it because devices were running out of PCI Configuration Space
> and PCI Extended Capabilities allow the device to use more space (PCI
> Express Extended Configuration Space).
>
> But now I think you're adding this to the spec in order to define VIRTIO
> features that depend on PCI Extended Capabilities like PASID support?


Right.


> Is
> it really necessary or just cleaner to use PCI Extended Capabilities
> instead of VIRTIO's existing vendor-specific PCI Capabilities?


Not a must, technically we can add them into the common configuration=20
structure. But having a dedicated capability seems cleaner: it looks odd=20
to configure PCIe features via the legacy capability anyhow. And this is=20
more flexible to allow the hypervisor to map or hide the BAR independently.


Thanks


>
> Stefan


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

