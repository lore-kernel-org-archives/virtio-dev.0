Return-Path: <xuanzhuo@linux.alibaba.com>
Message-ID: <1674891727.943683-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device virtio-ism
Date: Sat, 28 Jan 2023 15:42:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221223081354.15026-1-xuanzhuo@linux.alibaba.com>
 <20221223081354.15026-2-xuanzhuo@linux.alibaba.com>
 <20230110233401.131cc97a.pasic@linux.ibm.com>
 <1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
 <20230111161128.48e6d7e0.pasic@linux.ibm.com>
 <CACGkMEuT5L2DH1ga+HOJb0DHdF04VmvC3viEoRPhraLxc7RCjg@mail.gmail.com>
 <20230112014722-mutt-send-email-mst@kernel.org>
 <87zgaocffm.fsf@redhat.com>
 <1673524110.7417235-2-xuanzhuo@linux.alibaba.com>
 <87r0vzddul.fsf@redhat.com>
 <20230112164132.09d292e5.pasic@linux.ibm.com>
 <1673575104.6515808-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsm+9FJGm5m_nLkj9z0_vwXei+x9u+E1UxjoH0Ua=+oqw@mail.gmail.com>
 <1673591054.0941749-1-xuanzhuo@linux.alibaba.com>
 <20230113064742-mutt-send-email-mst@kernel.org>
 <1673835058.683712-1-xuanzhuo@linux.alibaba.com>
 <a6a20067-d071-e3a7-4dbc-2b024d54807b@linux.ibm.com>
In-Reply-To: <a6a20067-d071-e3a7-4dbc-2b024d54807b@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, Jan Kiszka <jan.kiszka@siemens.com>, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com, Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 19 Jan 2023 13:30:09 +0100, Alexandra Winter <wintera@linux.ibm.com=
> wrote:
>
>
> On 16.01.23 03:10, Xuan Zhuo wrote:
> > On Fri, 13 Jan 2023 07:00:51 -0500, "Michael S. Tsirkin" <mst@redhat.co=
m> wrote:
> >> On Fri, Jan 13, 2023 at 02:24:14PM +0800, Xuan Zhuo wrote:
> >>> On Fri, 13 Jan 2023 10:29:49 +0800, Jason Wang <jasowang@redhat.com> =
wrote:
> >>>> On Fri, Jan 13, 2023 at 9:59 AM Xuan Zhuo <xuanzhuo@linux.alibaba.co=
m> wrote:
> >>>>>
> >>>>> On Thu, 12 Jan 2023 16:41:32 +0100, Halil Pasic <pasic@linux.ibm.co=
m> wrote:
> >>>>>> On Thu, 12 Jan 2023 15:30:58 +0100
> >>>>>> Cornelia Huck <cohuck@redhat.com> wrote:
> >>>>>>
> [...]
> >>>>>>>>>
> >>>>>>>>> I'm just wondering how best to express the uniqueness scope, is=
 it per
> >>>>>>>>> (ISM) device?
> >>>>>>>>
> >>>>>>>> No, each vm has at least one separate device. The devices in a h=
ost form
> >>>>>>>> an uniqueness scope.
> >>>>>>>
> >>>>>>> Should we call it a 'group', then? A host would be an example of =
such a
> >>>>>>> group.
> >>>>>>
> >>>>>> How about 'communication domain'? Devices within a single communic=
ation
> >>>>>> domain may be able to speak to each other via SMC and may not have=
 the
> >>>>>> same device_id. Two devices from different communication domains c=
an't
> >>>>>> communicate via ISM, but may have the same device_id.
> >>>>>
> >>>>> I agree.
> >>>>>
> >>>>>>
> >>>>>> I don't like group because it is very generic, and may sound like
> >>>>>> the grouping can be done arbitrarily. E.g. with a shared memory ba=
sed
> >>>>>> implementation akin to the PoC putting devices on different hosts =
into
> >>>>>> the same 'group' should be illegal.
> >>>>
> >>>> Any reason why this is illegal?
> >>>
> >>> The ism device must on the same host.
> >>
> >> Fundamentally the limitation is that
> >> the devices must have access to the same memory.
> >> This is what we care about not who runs the VMs there's
> >> no need to mention that at all.
> >>
> >>
> [...]
> >>>>
> >>>>>>
> >>>>>> On the other hand there is also the following question. If we move=
 away
> >>>>>> form the one ID per host model ("The device MUST ensure that the g=
id on
> >>>>>> the same entity i same and different from the gid on other entity.=
") then
> >>>>>> we could also allow having more than one communication domains on =
a
> >>>>>> single host (to limit what entities can use ISM to communicate).
> >>>>
> >>>> Yes, but I think it might not be necessary to say how gid is actuall=
y
> >>>> implemented, I can think most of the time it should be provisioned b=
y
> >>>> the the management stack which is probably out of the scope of the
> >>>> spec.
> >>>
> >>> Imagine that the VMs from two different cloud manufacturers may have =
the same
> >>> GID (Host-Id). They believed that they can communicate based on ISM D=
evice. This
> >>> is wrong.
> >>>
> >>> Thanks.
> >>
> >> Let's leave all this talk about entities out it just serves to
> >> confuse. Same as with previous discussion, explain the
> >> limitation: two devices can access the same shared memory if and
> >> only if they have the same gid. And give an example of a host
> >> running multiple VMs.
> >
> >
> [...]
> One purpose of the proposed virtio device is to work with the SMC-D(irect=
) protocol
> (a variant of AF_SMC sockets). I understand that this virtio device shoul=
d be generic
> and usable for other purposes, but it also should be usable for SMC-D.
> SMC-D today can be used with s390's ISM devices. There we had to solve th=
e same questions
> - How to find 2 ISM devices that can communicate?
> Let me summarize the values we use in the SMC rendevous for this purpose,=
 maybe this
> helps this discussion.
>
> + UEID(s) =E2=80=93 (32 byte) Defined per system (OS instance). User defi=
ned group(s) of systems that should
>      use SMC between each other.
>      If the peer has only different UEIDs: Don=E2=80=99t try to use SMC w=
ith this peer.
>
> + SEID =E2=80=93 (32 byte) Defined per system. Maximum space of systems t=
hat are able to use SMC-D between each other.
>    Equals to the machine hardware / first level hypervisor. Is unique per=
 machine, derived from unique machine ID.
>     If the peer has a different SEID: Don=E2=80=99t try to use SMC-D with=
 this peer.
>
> + CHID =E2=80=93 (2 Bytes) Defined per SMC-D interface. Fabric ID of this=
 interface. Unique against other fabrics on this machine.
>     Try to find a pair of SMC-D interfaces on the same fabric for the 2 p=
eers for this SMC-D connection.
>
> + GID =E2=80=93 (8 bytes) Defined per SMC-D interface. ID of this interfa=
ce.
>    For s390 ISM is actually globally unique. But for SMC-D protocol purpo=
se just needs to be unique within the CHID (fabric).
>    Use it to identify the chosen interfaces to the other peer.
>
>
> You see the term GID is used for the interface, not for the fabric here.
>
> With this abstraction: Hardware, Fabric, Interface, we can say that 2 pee=
rs that are on the same
> Hardware (SEID) and can find a common Fabric (CHID) can use SMC-D to comm=
unicate and identify each
> other by Interface ID (GID).
> So for the KVM example, the fabric would be defined in the KVM host, and =
needs to be unique
> against other KVM hosts on the same hardware (in s390 KVM is at least the=
 second level hipervisor)
> and against s390 ISM fabrics.

Sorry for late, most of us are on Chinese New Year vacation.

Thanks for your explanation, I think I understand.

I agree.

So the problem we have to solve now is how to unify ISM device and virtio-i=
sm
device, which is beneficial to SMC Protocol.

For Virtio-ISM, we hope to simply return to SMC (or other applications) a I=
D (8 or 16 bytes)
through device, and ensure that it is unique against other hosts.

Thanks.



>
> HTH
>
>

