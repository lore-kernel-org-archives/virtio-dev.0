Return-Path: <mgurtovoy@nvidia.com>
Subject: Re: [PATCH V2 1/2] virtio: introduce virtqueue state as basic
 facility
References: <20210706043334.36359-1-jasowang@redhat.com>
 <20210706043334.36359-2-jasowang@redhat.com>
 <20210706051731-mutt-send-email-mst@kernel.org>
 <CAJaqyWeoc+KQZSc8PWre-G8=F8ph3Wx-E4K4vTY2x111FZTzZA@mail.gmail.com>
 <20210706150459-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <fba096c5-66f9-99ea-1174-e31d19fa01db@nvidia.com>
Date: Wed, 7 Jul 2021 02:49:25 +0300
MIME-Version: 1.0
In-Reply-To: <20210706150459-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Bodong Wang <bodong@nvidia.com>, Alexander Mikheev <amikheev@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 7/6/2021 10:08 PM, Michael S. Tsirkin wrote:
> On Tue, Jul 06, 2021 at 07:09:10PM +0200, Eugenio Perez Martin wrote:
>> On Tue, Jul 6, 2021 at 11:32 AM Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>>> On Tue, Jul 06, 2021 at 12:33:33PM +0800, Jason Wang wrote:
>>>> This patch adds new device facility to save and restore virtqueue
>>>> state. The virtqueue state is split into two parts:
>>>>
>>>> - The available state: The state that is used for read the next
>>>>    available buffer.
>>>> - The used state: The state that is used for making buffer used.
>>>>
>>>> Note that, there could be devices that is required to set and get the
>>>> requests that are being processed by the device. I leave such API to
>>>> be device specific.
>>>>
>>>> This facility could be used by both migration and device diagnostic.
>>>>
>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>>> Hi Jason!
>>> I feel that for use-cases such as SRIOV,
>>> the facility to save/restore vq should be part of a PF
>>> that is there needs to be a way for one virtio device to
>>> address the state of another one.
>>>
>> Hi!
>>
>> In my opinion we should go the other way around: To make features as
>> orthogonal/independent as possible, and just make them work together
>> if we have to. In this particular case, I think it should be easier to
>> decide how to report status, its needs, etc for a VF, and then open
>> the possibility for the PF to query or set them, reusing format,
>> behavior, etc. as much as possible.
>>
>> I think that the most controversial point about doing it non-SR IOV
>> way is the exposing of these features/fields to the guest using
>> specific transport facilities, like PCI common config. However I think
>> it should not be hard for the hypervisor to intercept them and even to
>> expose them conditionally. Please correct me if this guessing was not
>> right and you had other concerns.
>
> Possibly. I'd like to see some guidance on how this all will work
> in practice then. Maybe make it all part of a non-normative section
> for now.
> I think that the feature itself is not very useful outside of
> migration so we don't really gain much by adding it as is
> without all the other missing pieces.
> I would say let's see more of the whole picture before we commit.

I agree here. I also can't see the whole picture for SRIOV case.

I'll try to combine the admin control queue suggested in previous patch=20
set to my proposal of PF managing the VF migration.

Feature negotiation is part of virtio device-driver communication and=20
not part of the migration software that should manage the migration process=
.

For me, seems like queue state is something that should be internal and=20
not be exposed to guest drivers that see this as a new feature.

>
>
>
>>> Thoughts?
>>>
>>>> ---
>>>>   content.tex | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++
>>>>   1 file changed, 117 insertions(+)
>>>>
>>>> diff --git a/content.tex b/content.tex
>>>> index 620c0e2..8877b6f 100644
>>>> --- a/content.tex
>>>> +++ b/content.tex
>>>> @@ -385,6 +385,116 @@ \section{Exporting Objects}\label{sec:Basic Faci=
lities of a Virtio Device / Expo
>>>>   types. It is RECOMMENDED that devices generate version 4
>>>>   UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>>>>
>>>> +\section{Virtqueue State}\label{sec:Virtqueues / Virtqueue State}
>>>> +
>>>> +When VIRTIO_F_RING_STATE is negotiated, the driver can set and
>>>> +get the device internal virtqueue state through the following
>>>> +fields. The way to access those fields is transport specific.
>>>> +
>>>> +\subsection{\field{Available State} Field}
>>>> +
>>>> +The \field{Available State} field is two bytes for the driver to get
>>>> +or set the state that is used by the virtqueue to read for the next
>>>> +available buffer.
>>>> +
>>>> +When VIRTIO_F_RING_PACKED is not negotiated, it contains:
>>>> +
>>>> +\begin{lstlisting}
>>>> +le16 {
>>>> +        last_avail_idx : 16;
>>>> +} avail_state;
>>>> +\end{lstlisting}
>>>> +
>>>> +The \field{last_avail_idx} field indicates where the device would rea=
d
>>>> +for the next index from the virtqueue available ring=EF=BC=88modulo t=
he queue
>>>> + size). This starts at the value set by the driver, and increases.
>>>> +
>>>> +When VIRTIO_F_RING_PACKED is negotiated, it contains:
>>>> +
>>>> +\begin{lstlisting}
>>>> +le16 {
>>>> +        last_avail_idx : 15;
>>>> +        last_avail_wrap_counter : 1;
>>>> +} avail_state;
>>>> +\end{lstlisting}
>>>> +
>>>> +The \field{last_avail_idx} field indicates where the device would rea=
d for
>>>> +the next descriptor head from the descriptor ring. This starts at the
>>>> +value set by the driver and wraps around when reaching the end of the
>>>> +ring.
>>>> +
>>>> +The \field{last_avail_wrap_counter} field indicates the last Driver R=
ing
>>>> +Wrap Counter that is observed by the device. This starts at the value
>>>> +set by the driver, and is flipped when reaching the end of the ring.
>>>> +
>>>> +See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Cou=
nters}.
>>>> +
>>>> +\subsection{\field{Used State} Field}
>>>> +
>>>> +The \field{Used State} field is two bytes for the driver to set and
>>>> +get the state used by the virtqueue to make buffer used.
>>>> +
>>>> +When VIRTIO_F_RING_PACKED is not negotiated, the used state contains:
>>>> +
>>>> +\begin{lstlisting}
>>>> +le16 {
>>>> +        used_idx : 16;
>>>> +} used_state;
>>>> +\end{lstlisting}
>>>> +
>>>> +The \field{used_idx} where the device would write the next used
>>>> +descriptor head to the used ring (modulo the queue size). This starts
>>>> +at the value set by the driver, and increases. It is easy to see this
>>>> +is the initial value of the \field{idx} in the used ring.
>>>> +
>>>> +See also \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / =
The Virtqueue Used Ring}
>>>> +
>>>> +When VIRTIO_F_RING_PACKED is negotiated, the used state contains:
>>>> +
>>>> +\begin{lstlisting}
>>>> +le16 {
>>>> +        used_idx : 15;
>>>> +        used_wrap_counter : 1;
>>>> +} used_state;
>>>> +\end{lstlisting}
>>>> +
>>>> +The \field{used_idx} indicates where the device would write the next =
used
>>>> +descriptor head to the descriptor ring. This starts at the value set
>>>> +by the driver, and warps around when reaching the end of the ring.
>>>> +
>>>> +\field{used_wrap_counter} is the Device Ring Wrap Counter. This start=
s
>>>> +at the value set by the driver, and is flipped when reaching the end
>>>> +of the ring.
>>>> +
>>>> +See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Cou=
nters}.
>>>
>>> Above only fully describes the vq state if descriptors
>>> are used in order or at least all out of order descriptors are consumed
>>> at time of save.
>>>
>> I think that the most straightforward solution would be to add
>> something similar to VHOST_USER_GET_INFLIGHT_FD, but without the _FD
>> part.
>>
>> Thanks!
>>
>>> Adding later option to devices such as net will need extra spec work.
>>>
>>>
>>>> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of a =
Virtio Device / Virtqueue State}
>>>> +
>>>> +If VIRTIO_F_RING_STATE has been negotiated:
>>>> +\begin{itemize}
>>>> +\item A driver MUST NOT set the virtqueue state before setting the
>>>> +  FEATURE_OK status bit.
>>>> +\item A driver MUST NOT set the virtqueue state after setting the
>>>> +  DRIVER_OK status bit.
>>>> +\end{itemize}
>>>> +
>>>> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a =
Virtio Device / Virtqueue State}
>>>> +
>>>> +If VIRTIO_F_RING_STATE has not been negotiated, a device MUST ingore
>>>> +the read and write to the virtqueue state.
>>>> +
>>>> +If VIRTIO_F_RING_STATE has been negotiated:
>>>> +\begin{itemize}
>>>> +\item A device SHOULD ignore the write to the virtqueue state if the
>>>> +FEATURE_OK status bit is not set.
>>>> +\item A device SHOULD ignore the write to the virtqueue state if the
>>>> +DRIVER_OK status bit is set.
>>>> +\end{itemize}
>>>> +
>>>> +If VIRTIO_F_RING_STATE has been negotiated, a device MAY has its
>>>
>>> may have?
>>> should also go into a normative section
>>>
>>>> +device-specific way for the driver to set and get extra virtqueue
>>>> +states such as in flight requests.
>>>> +
>>>>   \chapter{General Initialization And Device Operation}\label{sec:Gene=
ral Initialization And Device Operation}
>>>>
>>>>   We start with an overview of device initialization, then expand on t=
he
>>>> @@ -420,6 +530,9 @@ \section{Device Initialization}\label{sec:General =
Initialization And Device Oper
>>>>      device, optional per-bus setup, reading and possibly writing the
>>>>      device's virtio configuration space, and population of virtqueues=
.
>>>>
>>>> +\item\label{itm:General Initialization And Device Operation / Device
>>>> +  Initialization / Virtqueue State Setup} When VIRTIO_F_RING_STATE ha=
s been negotiated, perform virtqueue state setup, including the initializat=
ion of the per virtqueue available state, used state and the possible devic=
e specific virtqueue state.
>>>> +
>>>>   \item\label{itm:General Initialization And Device Operation / Device=
 Initialization / Set DRIVER-OK} Set the DRIVER_OK status bit.  At this poi=
nt the device is
>>>>      ``live''.
>>>>   \end{enumerate}
>>>> @@ -6596,6 +6709,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reser=
ved Feature Bits}
>>>>     transport specific.
>>>>     For more details about driver notifications over PCI see \ref{sec:=
Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializatio=
n And Device Operation / Available Buffer Notifications}.
>>>>
>>>> +  \item[VIRTIO_F_RING_STATE(40)] This feature indicates that the driv=
er
>>>> +  can set and get the device internal virtqueue state.
>>>> +  See \ref{sec:Virtqueues / Virtqueue State}~\nameref{sec:Virtqueues =
/ Virtqueue State}.
>>>> +
>>>>   \end{description}
>>>>
>>>>   \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature B=
its}
>>>> --
>>>> 2.25.1

