Return-Path: virtio-dev-return-6821-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1E28985EDC
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Feb 2020 17:17:00 +0000 (UTC)
References: <87mu93vwy2.fsf@linaro.org>
 <db75fc2b-ac2e-2351-cc3c-cdb42a50ac24@siemens.com>
 <0b80da21-ed40-c550-c605-031a209115b1@siemens.com>
 <878skmwtei.fsf@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <a64fd962-8b62-58d9-9fe3-cc2aa686ac02@siemens.com>
Date: Fri, 28 Feb 2020 18:16:48 +0100
MIME-Version: 1.0
In-Reply-To: <878skmwtei.fsf@linaro.org>
Content-Language: en-US
Subject: [virtio-dev] Re: VIRTIO adoption in other hypervisors
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, Stefano Stabellini <sstabellini@kernel.org>, Wei Liu <liuw@liuw.name>
List-ID: <virtio-dev.lists.oasis-open.org>

On 28.02.20 17:47, Alex Benn=C3=A9e wrote:
>=20
> Jan Kiszka <jan.kiszka@siemens.com> writes:
>=20
>> On 28.02.20 11:30, Jan Kiszka wrote:
>>> On 28.02.20 11:16, Alex Benn=C3=A9e wrote:
>>>> Hi,
>>>>
> <snip>
>>>> I believe there has been some development work for supporting VIRTIO o=
n
>>>> Xen although it seems to have stalled according to:
>>>>
>>>>     https://wiki.xenproject.org/wiki/Virtio_On_Xen
>>>>
>>>> Recently at KVM Forum there was Jan's talk about Inter-VM shared memor=
y
>>>> which proposed ivshmemv2 as a VIRTIO transport:
>>>>
>>>>     https://events19.linuxfoundation.org/events/kvm-forum-2019/program=
/schedule/
>>>>
>>>>
>>>> As I understood it this would allow Xen (and other hypervisors) a simp=
le
>>>> way to be able to carry virtio traffic between guest and end point.
>>
>> And to clarify the scope of this effort: virtio-over-ivshmem is not
>> the fastest option to offer virtio to a guest (static "DMA" window),
>> but it is the simplest one from the hypervisor PoV and, thus, also
>> likely the easiest one to argue over when it comes to security and
>> safety.
>=20
> So to drill down on this is this a particular problem with type-1
> hypervisors?

Well, this typing doesn't help here (like it rarely does). There are=20
kvm-based setups that are stripped down and hardened in a way where=20
other folks would rather think of "type 1". I just had a discussion=20
around such a model for a cloud scenario that runs on kvm.

>=20
> It seems to me any KVM-like run loop trivially supports a range of
> virtio devices by virtue of trapping accesses to the signalling area of
> a virtqueue and allowing the VMM to handle the transaction which ever
> way it sees fit.
>=20
> I've not quite understood the way Xen interfaces to QEMU aside from it's
> different to everything else. More over it seems the type-1 hypervisors
> are more interested in providing better isolation between segments of a
> system whereas VIRTIO currently assumes either the VMM or the hypervisor
> has full access the full guest address space. I've seen quite a lot of
> slides that want to isolate sections of device emulation to separate
> processes or even separate guest VMs.

The point is in fact not only whether to trap IO accesses or to ask the=20
guest to rather target something like ivshmem (in fact, that is where=20
use cases I have in mind deviated from those of that cloud operator). It=20
is specifically the question how the backend should be able to transfer=20
data to/from the frontend. If you want to isolate the both from each=20
other (driver VMs/domains/etc.), you either need a complex virtual IOMMU=20
(or "grant tables") or a static DMA windows (like ivshmem). The former=20
is more efficient with large transfers, the latter is much simpler and=20
therefore more robust.

Jan

--=20
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

