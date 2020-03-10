Return-Path: virtio-dev-return-6910-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D779985D7D
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Mar 2020 06:39:22 +0000 (UTC)
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org>
 <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
 <20200309060238-mutt-send-email-mst@kernel.org>
 <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com>
 <20200310021729-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com>
Date: Tue, 10 Mar 2020 14:39:11 +0800
MIME-Version: 1.0
In-Reply-To: <20200310021729-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rob Miller <rob.miller@broadcom.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/3/10 =E4=B8=8B=E5=8D=882:24, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 11:22:00AM +0800, Jason Wang wrote:
>> On 2020/3/9 =E4=B8=8B=E5=8D=886:13, Michael S. Tsirkin wrote:
>>> On Mon, Mar 09, 2020 at 04:50:43PM +0800, Jason Wang wrote:
>>>> On 2020/3/9 =E4=B8=8B=E5=8D=883:38, Michael S. Tsirkin wrote:
>>>>> On Fri, Mar 06, 2020 at 10:40:13AM -0500, Rob Miller wrote:
>>>>>> I understand that DPT isn't really on the forefront of the vDPA fram=
ework, but
>>>>>> wanted to understand if there any initial thoughts on how this would=
 work...
>>>>> And judging by the next few chapters, you are actually
>>>>> talking about vhost pci, right?
>>>>>
>>>>>> In the migration framework, in its simplest form, (I gather) its QEM=
U via KVM
>>>>>> that is reading the dirty page table, converting bits to page number=
s, then
>>>>>> flushing remote VM/copying local page(s)->remote VM, ect.
>>>>>>
>>>>>> While this is fine for a VM (say VM1) dirtying its own memory and th=
e accesses
>>>>>> are trapped in the kernel as well as the log is being updated, I'm n=
ot sure
>>>>>> what happens in the situation=C2=A0of vhost, where a remote VM (say =
VM2) is dirtying
>>>>>> up VM1's memory since it can directly access it, during packet recep=
tion for
>>>>>> example.
>>>>>> Whatever technique is employed=C2=A0to catch this, how would this di=
ffer from a HW
>>>>>> based Virtio device doing DMA directly into a VM's DDR, wrt to DPT? =
Is QEMU
>>>>>> going to have a 2nd place to query the dirty logs - ie: the vDPA lay=
er?
>>>>> I don't think anyone has a good handle at the vhost pci migration yet=
.
>>>>> But I think a reasonable way to handle that would be to
>>>>> activate dirty tracking in VM2's QEMU.
>>>>>
>>>>> And then VM2's QEMU would periodically copy the bits to the log - doe=
s
>>>>> this sound right?
>>>>>
>>>>>> Further I heard about a SW based DPT within the vDPA framework for t=
hose
>>>>>> devices that do not (yet) support DPT inherently in HW. How is this =
envisioned
>>>>>> to work?
>>>>> What I am aware of is simply switching to a software virtio
>>>>> for the duration of migration. The software can be pretty simple
>>>>> since the formats match: just copy available entries to device ring,
>>>>> and for used entries, see a used ring entry, mark page
>>>>> dirty and then copy used entry to guest ring.
>>>> That looks more heavyweight than e.g just relay used ring (as what dpd=
k did)
>>>> I believe?
>>> That works for used but not for the packed ring.
>> For packed ring, we can relay the descriptor ring?
> Yes, and thus one must relay both available and used descriptors.
>

Yes.


> It's an interesting tradeoff. Packed ring at least was not designed
> with multiple actors in mind.


Yes.


> If this becomes a thing (and that's a big if) it might make sense to
> support temporarily reporting used entries in a separate buffer, while
> migration is in progress.  Also if doing this, it looks like we can then
> support used ring resize too, and thus it might also make sense to use
> this to support sharing a used ring between multiple available rings -
> this way a single CPU can handle multiple used rings efficiently.


Right, that's something similar to the two ring model I proposed in the=20
past.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

