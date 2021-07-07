Return-Path: <mgurtovoy@nvidia.com>
Subject: Re: [PATCH V2 1/2] virtio: introduce virtqueue state as basic
 facility
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-2-jasowang@redhat.com>
 <20210706051731-mutt-send-email-mst@kernel.org>
 <CAJaqyWeoc+KQZSc8PWre-G8=F8ph3Wx-E4K4vTY2x111FZTzZA@mail.gmail.com>
 <20210706150459-mutt-send-email-mst@kernel.org>
 <fba096c5-66f9-99ea-1174-e31d19fa01db@nvidia.com>
 <1973b90f-6a78-ded2-5249-8635ef15e67d@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20bb67da-fd93-b102-6d08-af693d0951dd@nvidia.com>
Date: Wed, 7 Jul 2021 15:03:37 +0300
MIME-Version: 1.0
In-Reply-To: <1973b90f-6a78-ded2-5249-8635ef15e67d@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 7/7/2021 5:50 AM, Jason Wang wrote:
>
> =E5=9C=A8 2021/7/7 =E4=B8=8A=E5=8D=887:49, Max Gurtovoy =E5=86=99=E9=81=
=93:
>>
>> On 7/6/2021 10:08 PM, Michael S. Tsirkin wrote:
>>> On Tue, Jul 06, 2021 at 07:09:10PM +0200, Eugenio Perez Martin wrote:
>>>> On Tue, Jul 6, 2021 at 11:32 AM Michael S. Tsirkin <mst@redhat.com>=20
>>>> wrote:
>>>>> On Tue, Jul 06, 2021 at 12:33:33PM +0800, Jason Wang wrote:
>>>>>> This patch adds new device facility to save and restore virtqueue
>>>>>> state. The virtqueue state is split into two parts:
>>>>>>
>>>>>> - The available state: The state that is used for read the next
>>>>>> =C2=A0=C2=A0 available buffer.
>>>>>> - The used state: The state that is used for making buffer used.
>>>>>>
>>>>>> Note that, there could be devices that is required to set and get=20
>>>>>> the
>>>>>> requests that are being processed by the device. I leave such API to
>>>>>> be device specific.
>>>>>>
>>>>>> This facility could be used by both migration and device diagnostic.
>>>>>>
>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>>>> Hi Jason!
>>>>> I feel that for use-cases such as SRIOV,
>>>>> the facility to save/restore vq should be part of a PF
>>>>> that is there needs to be a way for one virtio device to
>>>>> address the state of another one.
>>>>>
>>>> Hi!
>>>>
>>>> In my opinion we should go the other way around: To make features as
>>>> orthogonal/independent as possible, and just make them work together
>>>> if we have to. In this particular case, I think it should be easier to
>>>> decide how to report status, its needs, etc for a VF, and then open
>>>> the possibility for the PF to query or set them, reusing format,
>>>> behavior, etc. as much as possible.
>>>>
>>>> I think that the most controversial point about doing it non-SR IOV
>>>> way is the exposing of these features/fields to the guest using
>>>> specific transport facilities, like PCI common config. However I think
>>>> it should not be hard for the hypervisor to intercept them and even to
>>>> expose them conditionally. Please correct me if this guessing was not
>>>> right and you had other concerns.
>>>
>>> Possibly. I'd like to see some guidance on how this all will work
>>> in practice then. Maybe make it all part of a non-normative section
>>> for now.
>>> I think that the feature itself is not very useful outside of
>>> migration so we don't really gain much by adding it as is
>>> without all the other missing pieces.
>>> I would say let's see more of the whole picture before we commit.
>>
>> I agree here. I also can't see the whole picture for SRIOV case.
>
>
> Again, it's not related to SR-IOV at all. It tries to introduce basic=20
> facility in the virtio level which can work for all types of virtio=20
> device.
>
> Transport such as PCI need to implement its own way to access those=20
> state. It's not hard to implement them simply via capability.
>
> It works like other basic facility like device status, features etc.
>
> For SR-IOV, it doesn't prevent you from implementing that via the=20
> admin virtqueue.
>
>
>>
>> I'll try to combine the admin control queue suggested in previous=20
>> patch set to my proposal of PF managing the VF migration.
>
>
> Note that, the admin virtqueue should be transport indepedent when=20
> trying to introduce them.
>
>
>>
>> Feature negotiation is part of virtio device-driver communication and=20
>> not part of the migration software that should manage the migration=20
>> process.
>>
>> For me, seems like queue state is something that should be internal=20
>> and not be exposed to guest drivers that see this as a new feature.
>
>
> This is not true, we have the case of nested virtualization. As=20
> mentioned in another thread, it's the hypervisor that need to choose=20
> between hiding or shadowing the internal virtqueue state.
>
> Thanks

In the nested environment, do you mean the Level 1 is Real PF with X VFs=20
and in Level 2 the X VF seen as PFs in the guests and expose another Y VFs =
?

If so, the guest PF will manage the migration for it's Y VFs.


>
>
>>
>>>
>>>
>>>
>>>>> Thoughts?
>>>>>
>>>>>> ---
>>>>>> =C2=A0 content.tex | 117=20
>>>>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>>> =C2=A0 1 file changed, 117 insertions(+)
>>>>>>
>>>>>> diff --git a/content.tex b/content.tex
>>>>>> index 620c0e2..8877b6f 100644
>>>>>> --- a/content.tex
>>>>>> +++ b/content.tex
>>>>>> @@ -385,6 +385,116 @@ \section{Exporting Objects}\label{sec:Basic=20
>>>>>> Facilities of a Virtio Device / Expo
>>>>>> =C2=A0 types. It is RECOMMENDED that devices generate version 4
>>>>>> =C2=A0 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>>>>>>
>>>>>> +\section{Virtqueue State}\label{sec:Virtqueues / Virtqueue State}
>>>>>> +
>>>>>> +When VIRTIO_F_RING_STATE is negotiated, the driver can set and
>>>>>> +get the device internal virtqueue state through the following
>>>>>> +fields. The way to access those fields is transport specific.
>>>>>> +
>>>>>> +\subsection{\field{Available State} Field}
>>>>>> +
>>>>>> +The \field{Available State} field is two bytes for the driver to=20
>>>>>> get
>>>>>> +or set the state that is used by the virtqueue to read for the next
>>>>>> +available buffer.
>>>>>> +
>>>>>> +When VIRTIO_F_RING_PACKED is not negotiated, it contains:
>>>>>> +
>>>>>> +\begin{lstlisting}
>>>>>> +le16 {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_avail_idx : 16;
>>>>>> +} avail_state;
>>>>>> +\end{lstlisting}
>>>>>> +
>>>>>> +The \field{last_avail_idx} field indicates where the device=20
>>>>>> would read
>>>>>> +for the next index from the virtqueue available ring=EF=BC=88modulo=
 the=20
>>>>>> queue
>>>>>> + size). This starts at the value set by the driver, and increases.
>>>>>> +
>>>>>> +When VIRTIO_F_RING_PACKED is negotiated, it contains:
>>>>>> +
>>>>>> +\begin{lstlisting}
>>>>>> +le16 {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_avail_idx : 15;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 last_avail_wrap_counter =
: 1;
>>>>>> +} avail_state;
>>>>>> +\end{lstlisting}
>>>>>> +
>>>>>> +The \field{last_avail_idx} field indicates where the device=20
>>>>>> would read for
>>>>>> +the next descriptor head from the descriptor ring. This starts=20
>>>>>> at the
>>>>>> +value set by the driver and wraps around when reaching the end=20
>>>>>> of the
>>>>>> +ring.
>>>>>> +
>>>>>> +The \field{last_avail_wrap_counter} field indicates the last=20
>>>>>> Driver Ring
>>>>>> +Wrap Counter that is observed by the device. This starts at the=20
>>>>>> value
>>>>>> +set by the driver, and is flipped when reaching the end of the=20
>>>>>> ring.
>>>>>> +
>>>>>> +See also \ref{sec:Packed Virtqueues / Driver and Device Ring=20
>>>>>> Wrap Counters}.
>>>>>> +
>>>>>> +\subsection{\field{Used State} Field}
>>>>>> +
>>>>>> +The \field{Used State} field is two bytes for the driver to set and
>>>>>> +get the state used by the virtqueue to make buffer used.
>>>>>> +
>>>>>> +When VIRTIO_F_RING_PACKED is not negotiated, the used state=20
>>>>>> contains:
>>>>>> +
>>>>>> +\begin{lstlisting}
>>>>>> +le16 {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 used_idx : 16;
>>>>>> +} used_state;
>>>>>> +\end{lstlisting}
>>>>>> +
>>>>>> +The \field{used_idx} where the device would write the next used
>>>>>> +descriptor head to the used ring (modulo the queue size). This=20
>>>>>> starts
>>>>>> +at the value set by the driver, and increases. It is easy to see=20
>>>>>> this
>>>>>> +is the initial value of the \field{idx} in the used ring.
>>>>>> +
>>>>>> +See also \ref{sec:Basic Facilities of a Virtio Device /=20
>>>>>> Virtqueues / The Virtqueue Used Ring}
>>>>>> +
>>>>>> +When VIRTIO_F_RING_PACKED is negotiated, the used state contains:
>>>>>> +
>>>>>> +\begin{lstlisting}
>>>>>> +le16 {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 used_idx : 15;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 used_wrap_counter : 1;
>>>>>> +} used_state;
>>>>>> +\end{lstlisting}
>>>>>> +
>>>>>> +The \field{used_idx} indicates where the device would write the=20
>>>>>> next used
>>>>>> +descriptor head to the descriptor ring. This starts at the value=20
>>>>>> set
>>>>>> +by the driver, and warps around when reaching the end of the ring.
>>>>>> +
>>>>>> +\field{used_wrap_counter} is the Device Ring Wrap Counter. This=20
>>>>>> starts
>>>>>> +at the value set by the driver, and is flipped when reaching the=20
>>>>>> end
>>>>>> +of the ring.
>>>>>> +
>>>>>> +See also \ref{sec:Packed Virtqueues / Driver and Device Ring=20
>>>>>> Wrap Counters}.
>>>>>
>>>>> Above only fully describes the vq state if descriptors
>>>>> are used in order or at least all out of order descriptors are=20
>>>>> consumed
>>>>> at time of save.
>>>>>
>>>> I think that the most straightforward solution would be to add
>>>> something similar to VHOST_USER_GET_INFLIGHT_FD, but without the _FD
>>>> part.
>>>>
>>>> Thanks!
>>>>
>>>>> Adding later option to devices such as net will need extra spec work.
>>>>>
>>>>>
>>>>>> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities=20
>>>>>> of a Virtio Device / Virtqueue State}
>>>>>> +
>>>>>> +If VIRTIO_F_RING_STATE has been negotiated:
>>>>>> +\begin{itemize}
>>>>>> +\item A driver MUST NOT set the virtqueue state before setting the
>>>>>> +=C2=A0 FEATURE_OK status bit.
>>>>>> +\item A driver MUST NOT set the virtqueue state after setting the
>>>>>> +=C2=A0 DRIVER_OK status bit.
>>>>>> +\end{itemize}
>>>>>> +
>>>>>> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities=20
>>>>>> of a Virtio Device / Virtqueue State}
>>>>>> +
>>>>>> +If VIRTIO_F_RING_STATE has not been negotiated, a device MUST=20
>>>>>> ingore
>>>>>> +the read and write to the virtqueue state.
>>>>>> +
>>>>>> +If VIRTIO_F_RING_STATE has been negotiated:
>>>>>> +\begin{itemize}
>>>>>> +\item A device SHOULD ignore the write to the virtqueue state if=20
>>>>>> the
>>>>>> +FEATURE_OK status bit is not set.
>>>>>> +\item A device SHOULD ignore the write to the virtqueue state if=20
>>>>>> the
>>>>>> +DRIVER_OK status bit is set.
>>>>>> +\end{itemize}
>>>>>> +
>>>>>> +If VIRTIO_F_RING_STATE has been negotiated, a device MAY has its
>>>>>
>>>>> may have?
>>>>> should also go into a normative section
>>>>>
>>>>>> +device-specific way for the driver to set and get extra virtqueue
>>>>>> +states such as in flight requests.
>>>>>> +
>>>>>> =C2=A0 \chapter{General Initialization And Device=20
>>>>>> Operation}\label{sec:General Initialization And Device Operation}
>>>>>>
>>>>>> =C2=A0 We start with an overview of device initialization, then expa=
nd=20
>>>>>> on the
>>>>>> @@ -420,6 +530,9 @@ \section{Device=20
>>>>>> Initialization}\label{sec:General Initialization And Device Oper
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 device, optional per-bus setup, reading and=
 possibly writing=20
>>>>>> the
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 device's virtio configuration space, and po=
pulation of=20
>>>>>> virtqueues.
>>>>>>
>>>>>> +\item\label{itm:General Initialization And Device Operation /=20
>>>>>> Device
>>>>>> +=C2=A0 Initialization / Virtqueue State Setup} When=20
>>>>>> VIRTIO_F_RING_STATE has been negotiated, perform virtqueue state=20
>>>>>> setup, including the initialization of the per virtqueue=20
>>>>>> available state, used state and the possible device specific=20
>>>>>> virtqueue state.
>>>>>> +
>>>>>> =C2=A0 \item\label{itm:General Initialization And Device Operation /=
=20
>>>>>> Device Initialization / Set DRIVER-OK} Set the DRIVER_OK status=20
>>>>>> bit.=C2=A0 At this point the device is
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 ``live''.
>>>>>> =C2=A0 \end{enumerate}
>>>>>> @@ -6596,6 +6709,10 @@ \chapter{Reserved Feature=20
>>>>>> Bits}\label{sec:Reserved Feature Bits}
>>>>>> =C2=A0=C2=A0=C2=A0 transport specific.
>>>>>> =C2=A0=C2=A0=C2=A0 For more details about driver notifications over =
PCI see=20
>>>>>> \ref{sec:Virtio Transport Options / Virtio Over PCI Bus /=20
>>>>>> PCI-specific Initialization And Device Operation / Available=20
>>>>>> Buffer Notifications}.
>>>>>>
>>>>>> +=C2=A0 \item[VIRTIO_F_RING_STATE(40)] This feature indicates that t=
he=20
>>>>>> driver
>>>>>> +=C2=A0 can set and get the device internal virtqueue state.
>>>>>> +=C2=A0 See \ref{sec:Virtqueues / Virtqueue=20
>>>>>> State}~\nameref{sec:Virtqueues / Virtqueue State}.
>>>>>> +
>>>>>> =C2=A0 \end{description}
>>>>>>
>>>>>> =C2=A0 \drivernormative{\section}{Reserved Feature Bits}{Reserved=20
>>>>>> Feature Bits}
>>>>>> --=20
>>>>>> 2.25.1
>>
>

