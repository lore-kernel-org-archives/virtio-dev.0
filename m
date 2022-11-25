Return-Path: <virtio-return-3934-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <5731c35c-f24d-3667-b3be-c2f86f849b92@redhat.com>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-3-mst@redhat.com>
 <CACGkMEuuHgJ-yZmMAu0L=piUmZa8sY-v7e5FyTrpUSdZML5KUA@mail.gmail.com>
 <20221124020650-mutt-send-email-mst@kernel.org>
 <CACGkMEtF0WLEiDPQw5W7o0f+JvkFSbX++uOc-SPYHsnFMXyJgw@mail.gmail.com>
 <20221124031554-mutt-send-email-mst@kernel.org>
 <87h6yoh7pj.fsf@redhat.com>
 <5731c35c-f24d-3667-b3be-c2f86f849b92@redhat.com>
Date: Fri, 25 Nov 2022 11:58:49 +0100
Message-ID: <87wn7jgv12.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [virtio-dev] Re: [PATCH v9 02/10] admin: introduce device group
 and related concepts
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 25 2022, Jason Wang <jasowang@redhat.com> wrote:

> =E5=9C=A8 2022/11/24 20:12, Cornelia Huck =E5=86=99=E9=81=93:
>> On Thu, Nov 24 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>>
>>> On Thu, Nov 24, 2022 at 03:37:42PM +0800, Jason Wang wrote:
>>>> On Thu, Nov 24, 2022 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wr=
ote:
>>>>> On Thu, Nov 24, 2022 at 01:41:41PM +0800, Jason Wang wrote:
>>>>>> On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>>>>>>> +The following group types, and their identifiers, are currently sp=
ecified):
>>>>>>> +\begin{description}
>>>>>>> +\item[SR-IOV group type (0x1)]
>>>>>>> +This device group has a PCI Single Root I/O Virtualization
>>>>>>> +(SR-IOV) physical function (PF) device as the owner and includes
>>>>>>> +all its SR-IOV virtual functions (VFs) as members (see
>>>>>>> +\hyperref[intro:PCIe]{[PCIe]}).
>>>>>> So I wonder what's the advantage of using a global identifier over t=
he
>>>>>> transport specific one. There's almost no way for CCW/MMIO to use
>>>>>> SR-IOV. Limiting it to PCI seems much easier and avoids layer
>>>>>> violation.
>>>>>>
>>>>>> Thanks
>>>>> So we burn up an identifier, ccw and mmio won't be able to use it.
>>>>> Big deal? Why?
>>>> Because it is transport specific. The basic facility should be
>>>> transport independent.
>>> I tried this but the result is spread all over the spec
>>> and does not result in a readable cohesive whole.
>
>
> I may miss something, but it looks to me it's just a subsection in the=20
> PCI transport to describe the SR-IOV group identifier.
>
>
>>> So we give up on the transport independent purity a bit and it
>>> seems worth it.
>>> Also explained this in the cover letter - have you seen that?
>
>
> Sorry, I don't.
>
>
>>>
>>>
>>>
>>>>> And I think we might find a use for this with MMIO
>>>>> down the road with some kind of passthrough. Who knows.
>>>> Probably, but can it be modeled exactly as what SR-IOV looks like? Or
>>>> anyhow, it's not too late to define this for MMIO at that time. For
>>>> example, we know MSI-X may work for MMIO but we define it only for PCI
>>>> now.
>>>>
>>>> Thanks
>>> Right. So if we reserve the id for all transports then it will
>>> be easy to do.
>> Also, if we go with transport-specific ids, we might end up with
>> different ids per transport when we add a future transport-independent
>> feature.
>
>
> I'm not sure this is a real problem:
>
> 1) all the basic facilities are now transport-independent but they are=20
> implemented via different transport specific registers/commands/offsets e=
tc.

Yes, but in this case we're using the same basic structure, just with a
different id. I think that has a high potential for errors.

> 2) I'm not quite sure there would be a transport-independent group=20
> identifier other than the virtqueue transport, so I wonder if it makes=20
> sense to split the id space into global ones as well as the transport=20
> specific ones

I think global vs. transport-specific is overkill here. I don't think we
expect a flood of new group types.

>
>
>>   The global id space really should be big enough to accommodate
>> even single-transport groups.
>
>
> Yes, so it's not about the space but about whether or it it's=20
> worth/correct/expensive to describe a transport specific identifier in=20
> the basic facility part.

IMHO, splitting this or using transport-specific namespaces is making
this complicated for not much in return. What do others think?


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

