Return-Path: <virtio-comment-return-2889-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <1b56833e-6530-98c5-61cf-8502d7c43e4a@nvidia.com>
Date: Mon, 4 Apr 2022 18:06:36 +0300
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
 <20220302155608.24189-2-mgurtovoy@nvidia.com>
 <20220404072833-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220404072833-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v1 1/5] virtio: Introduce virtio subsystem
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 4/4/2022 3:03 PM, Michael S. Tsirkin wrote:
> On Wed, Mar 02, 2022 at 05:56:04PM +0200, Max Gurtovoy wrote:
>> A virtio subsystem may contain one or more virtio devices. All of the
>> devices that make up a virtio subsystem share the same virtio subsystem
>> unique identifier. This identifier is the virtio qualified name (VQN).
>> Each device within a virtio subsystem has a unique identifier. This
>> identifier is the virtio device id (vdev_id). The combination of these
>> identifiers forms a globally unique value identifies a virtio device.
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> OK linux and qemu releases finally settling down so I have the time
> to review this, sorry about the delay.
>
>> ---
>>   introduction.tex | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/introduction.tex b/introduction.tex
>> index 6d52717..8e6611e 100644
>> --- a/introduction.tex
>> +++ b/introduction.tex
>> @@ -240,5 +240,23 @@ \section{Constant Specifications}
>>   refer to values 1 and 2 of Fld respectively. Further, VIRTIO_FLD_XXX r=
efers to
>>   either VIRTIO_FLD_A or VIRTIO_FLD_B.
>>  =20
>> +\section{Definitions}\label{sec:Introduction / Definitions}
> I think this belongs in Terminology section.

Ok, I can move all definitions to Terminology section.

>
>> +
>> +\subsection{virtio device}\label{sec:Introduction / Definitions / virti=
o device}
>> +
>> +An entity that implements virtio specification.
> Applies to a driver equally ... if we are trying to explain it further,
> then I would say something along the lines of:
>
> virtio specifies an interface
> for a two-way communication between two parties called
> a device and a driver. driver is the party that initiates
> the communication setup and initialization.
> in common usage device is part of a hypervisor and driver part
> of a guest running within a VM on this hypervisor,
> but other uses are not precluded.

I think this is true for the paravirt world. I wouldn't mention hyperv=20
and guest in such generic chapters.

So lets do:

"virtio specifies an interface for a two-way communication between two=20
parties called a device and a driver.

 =C2=A0 driver is the party that initiates the communication setup and=20
initialization. Device is the party that implements the virtio=20
specification."


>
>
>> +\subsection{virtio subsystem}\label{sec:Introduction / Definitions / vi=
rtio subsystem}
>> +
>> +A virtio subsystem includes one or more virtio devices.
>> +Each virtio subsystem has a unique virtio qualified name (VQN) that is =
permanent for the lifetime of the virtio subsystem.
> the naming here is unfortunate. "subsystem" generally refers to
> something like a group of drivers within linux, and to a type of

Not always.


> device in pci. VQN refers to a VQ number in the spec.
>
> I would suggest simply "device group".

So you prefer call it "virtio group" instead of "virtio subsystem" and=20
rename VQN to VGQN (Virtio Group Qualified Name) ?

device group doesn't sounds right.

>
> And please preface this with a bit of informal text explaining that
> sometimes it is useful to refer to a group of devices
> as a whole.
>
>
>> +The VQN is a 128-bit UUID. It is RECOMMENDED to use UUIDs as specified =
by \hyperref[intro:rfc4122]{[RFC4122]}.
>
> Do we really need the UUID at all? It is unique within which context?
> Can we split the UUID from this proposal?
Why ? This is the identifier of the group. This is the whole point of=20
the proposal.
>> +Virtio devices within one virtio subsystem share the same VQN.
> share in which sense? I don't see any way to retrieve the VQN from
> the device itself.

Didn't you review the admin cmds in the next patch ?


>
>> Each virtio device has a unique virtio
>> +device id (vdev_id) within a virtio subsystem. A valid vdev_id is a 64-=
bit field in the range of
>> +0x0 - 0xFFFFFFFFFFFFFFF0.
> are other values reserved?

0xFFFFFFFFFFFFFFF1 - 0xFFFFFFFFFFFFFFFE are reserved.

>> Vdev_id 0xFFFFFFFFFFFFFFFF is a broadcast value that is used to specify =
all the
>> +virtio devices in a virtio subsystem and isn't a valid vdev_id.
> broadcast is a bit confusing. Just say "Vdev_id value 0xFFFFFFFFFFFFFFFF
> refers to all devices in a group".

Ok.

>
> I think we should also add a special value meaning "this device itself".

This is the id inside the group. The "device itself" reference is a=20
property of commands.

No need for self value. Each device knows it's id.

>
>> +
>> +The vdev_id value when combined with the VQN forms a globally unique va=
lue that identifies the virtio device.
>> +
>>   \newpage
>
>
>> --=20
>> 2.21.0

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

