Return-Path: virtio-dev-return-6962-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 72FBC985DC1
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Mar 2020 03:35:53 +0000 (UTC)
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org>
 <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
 <20200309060238-mutt-send-email-mst@kernel.org>
 <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com>
 <20200310021729-mutt-send-email-mst@kernel.org>
 <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com>
 <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c8c7a679-fa9f-28a4-2e31-110327232766@redhat.com>
Date: Thu, 19 Mar 2020 11:35:34 +0800
MIME-Version: 1.0
In-Reply-To: <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Rob Miller <rob.miller@broadcom.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/3/18 =E4=B8=8B=E5=8D=8811:13, Rob Miller wrote:
> In trying to more fully understand DPT, I ran across an article=20
> regarding how Physical RAM works within QEMU and noticed the statement=20
> below. My current understanding, based upon the statement, is that DPT=20
> is automatic inside QEMU. I can understand that this scheme=C2=A0is not=
=20
> employed=C2=A0in all hypervisors, but i'm wondering if others, b/c of VM=
=20
> migration, do have a similar=C2=A0scheme.
>
>
>     Dirty memory tracking
>
> When the guest CPU or device DMA stores to guest RAM this needs to be=20
> noticed by several users:
>
>  1. The live migration feature relies on tracking dirty memory pages
>     so they can be resent if they change during live migration.
>  2. TCG relies on tracking self-modifying code so it can recompile
>     changed instructions.
>  3. Graphics card emulation relies on tracking dirty video memory to
>     redraw only scanlines that have changed.
>
> There are dirty memory bitmaps for each of these users in ram_list=20
> because dirty memory tracking can be enabled or disabled independently=20
> for each of these users.
>
> http://blog.vmsplice.net/2016/01/qemu-internals-how-guest-physical-ram.ht=
ml=20
>
>
> Rob Miller
> rob.miller@broadcom.com <mailto:rob.miller@broadcom.com>
> (919)721-3339


Hi Rob:

My understanding is DPT is a must for all hypervisors that want to=20
support live migration.

For qemu, except for tracking dirty pages by itself, it can also syncs=20
dirty pages from external users like:

- KVM: which can write protect pages and track dirty page through #PF
- vhost: which is a software virtio backend which can track the used=20
ring and then know which page were modified
- VFIO: the work of syncing dirty pages from hardware is ongoing.

For vDPA, we have two ways do that:

- pure software solution, qemu vhost-vdpa backend will take over the=20
ring (used ring for split for example), then it can know which part of=20
guest memory was modified by vDPA and report the dirty pages through=20
qemu internal helpers.
- hardware solution, when hardware support dirty page tracking, vDPA bus=20
need to be extended to allow hardware to report dirty pages (bitmap or=20
other), and qemu can sync them from vhost.

Thanks



>
>
> On Tue, Mar 10, 2020 at 2:39 AM Jason Wang <jasowang@redhat.com=20
> <mailto:jasowang@redhat.com>> wrote:
>
>
>     On 2020/3/10 =E4=B8=8B=E5=8D=882:24, Michael S. Tsirkin wrote:
>     > On Tue, Mar 10, 2020 at 11:22:00AM +0800, Jason Wang wrote:
>     >> On 2020/3/9 =E4=B8=8B=E5=8D=886:13, Michael S. Tsirkin wrote:
>     >>> On Mon, Mar 09, 2020 at 04:50:43PM +0800, Jason Wang wrote:
>     >>>> On 2020/3/9 =E4=B8=8B=E5=8D=883:38, Michael S. Tsirkin wrote:
>     >>>>> On Fri, Mar 06, 2020 at 10:40:13AM -0500, Rob Miller wrote:
>     >>>>>> I understand that DPT isn't really on the forefront of the
>     vDPA framework, but
>     >>>>>> wanted to understand if there any initial thoughts on how
>     this would work...
>     >>>>> And judging by the next few chapters, you are actually
>     >>>>> talking about vhost pci, right?
>     >>>>>
>     >>>>>> In the migration framework, in its simplest form, (I
>     gather) its QEMU via KVM
>     >>>>>> that is reading the dirty page table, converting bits to
>     page numbers, then
>     >>>>>> flushing remote VM/copying local page(s)->remote VM, ect.
>     >>>>>>
>     >>>>>> While this is fine for a VM (say VM1) dirtying its own
>     memory and the accesses
>     >>>>>> are trapped in the kernel as well as the log is being
>     updated, I'm not sure
>     >>>>>> what happens in the situation=C2=A0of vhost, where a remote VM
>     (say VM2) is dirtying
>     >>>>>> up VM1's memory since it can directly access it, during
>     packet reception for
>     >>>>>> example.
>     >>>>>> Whatever technique is employed=C2=A0to catch this, how would
>     this differ from a HW
>     >>>>>> based Virtio device doing DMA directly into a VM's DDR, wrt
>     to DPT? Is QEMU
>     >>>>>> going to have a 2nd place to query the dirty logs - ie: the
>     vDPA layer?
>     >>>>> I don't think anyone has a good handle at the vhost pci
>     migration yet.
>     >>>>> But I think a reasonable way to handle that would be to
>     >>>>> activate dirty tracking in VM2's QEMU.
>     >>>>>
>     >>>>> And then VM2's QEMU would periodically copy the bits to the
>     log - does
>     >>>>> this sound right?
>     >>>>>
>     >>>>>> Further I heard about a SW based DPT within the vDPA
>     framework for those
>     >>>>>> devices that do not (yet) support DPT inherently in HW. How
>     is this envisioned
>     >>>>>> to work?
>     >>>>> What I am aware of is simply switching to a software virtio
>     >>>>> for the duration of migration. The software can be pretty simpl=
e
>     >>>>> since the formats match: just copy available entries to
>     device ring,
>     >>>>> and for used entries, see a used ring entry, mark page
>     >>>>> dirty and then copy used entry to guest ring.
>     >>>> That looks more heavyweight than e.g just relay used ring (as
>     what dpdk did)
>     >>>> I believe?
>     >>> That works for used but not for the packed ring.
>     >> For packed ring, we can relay the descriptor ring?
>     > Yes, and thus one must relay both available and used descriptors.
>     >
>
>     Yes.
>
>
>     > It's an interesting tradeoff. Packed ring at least was not designed
>     > with multiple actors in mind.
>
>
>     Yes.
>
>
>     > If this becomes a thing (and that's a big if) it might make sense t=
o
>     > support temporarily reporting used entries in a separate buffer,
>     while
>     > migration is in progress.=C2=A0 Also if doing this, it looks like w=
e
>     can then
>     > support used ring resize too, and thus it might also make sense
>     to use
>     > this to support sharing a used ring between multiple available
>     rings -
>     > this way a single CPU can handle multiple used rings efficiently.
>
>
>     Right, that's something similar to the two ring model I proposed
>     in the
>     past.
>
>     Thanks
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

