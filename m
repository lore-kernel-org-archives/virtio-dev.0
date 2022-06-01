Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <152fa52f-23c3-b222-68f6-db42b4231144@nvidia.com>
Date: Wed, 1 Jun 2022 16:43:48 +0300
Subject: Re: [virtio-comment] Re: [PATCH v5 1/7] Introduce device group
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-2-mgurtovoy@nvidia.com>
 <20220515112412-mutt-send-email-mst@kernel.org>
 <b2239b43-a542-2d54-ecb2-86c0f4e35dd0@nvidia.com> <87o7zvezkc.fsf@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <87o7zvezkc.fsf@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 5/18/2022 4:32 PM, Cornelia Huck wrote:
> On Wed, May 18 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>> Hi MST,
>>
>> On 5/15/2022 6:25 PM, Michael S. Tsirkin wrote:
>>> On Wed, Apr 27, 2022 at 01:58:18AM +0300, Max Gurtovoy wrote:
>>>> +\subsection{Device group}\label{sec:Introduction / Terminology / Devi=
ce group}
>>>> +
>>>> +A device group includes one or more virtio devices.
>>>> +Each virtio device has a unique virtio device id (vdev_id) within a d=
evice group. A valid vdev_id is a 64-bit field in the range of
>>>> +0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a value that =
refers to all devices in a device group and isn't a valid vdev_id.
>>>> +
>>>> +For now, the supported device groups are:
>>>> +\begin{enumerate}
>>>> +\item Type 1 - A virtio PCI SR-IOV physical function (PF) and its PCI=
 SR-IOV virtual functions (VFs). For this group type, the PF device has vde=
v_id that is equal to 0
>>>> +and the VF devices have vdev_id's that are equal to their vf_number (=
according to the PCI SR-IOV specification).
>>>> +\end{enumerate}
>>>> +
>>>>    \section{Structure Specifications}\label{sec:Structure Specificatio=
ns}
>>> In context of virtualization type 1 already refers to a specific type
>>> of hypervisor.
>>>
>>> I suggest simply "SR-IOV type" - this way users do not need to remember
>>> special terminology.
>> This is 12 lines addition commit with simple definition.
>>
>> I didn't mentioned hypervisors here.
>>
>> I will stick to your suggestion and use name instead of numbers
>> (although I don't understand how can a use that knows how to read spec
>> will be confused here), but I would like Jason and Cornelia to ack on
>> this during this review cycle.
>>
>> When we'll get 3 acks on this name - I'll update it for v6.
> So, do you want to imply some kind of numbering? I don't like "Type 1",
> either. If the type needs to be referenced in code, it should have a
> #define or such; otherwise, "SR-IOV type" would be fine.

ok I'll change it to be:

diff --git a/introduction.tex b/introduction.tex
index aa9ec1b..bba70a6 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -156,6 +156,18 @@ \subsection{Transition from earlier specification=20
drafts}\label{sec:Transition f
 =C2=A0sections tagged "Legacy Interface" in the section title.
 =C2=A0These highlight the changes made since the earlier drafts.

+\subsection{Device group}\label{sec:Introduction / Terminology / Device=20
group}
+
+A device group includes one or more virtio devices.
+Each virtio device has a unique virtio device id (vdev_id) within a=20
device group. A valid vdev_id is a 64-bit field in the range of
+0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a value that=20
refers to all devices in a device group and isn't a valid vdev_id.
+
+For now, the supported device groups are:
+\begin{enumerate}
+\item SR-IOV type - A virtio PCI SR-IOV physical function (PF) and its=20
PCI SR-IOV virtual functions (VFs). For this group type, the PF device=20
has vdev_id that is equal to 0
+and the VF devices have vdev_id's that are equal to their vf_number=20
(according to the PCI SR-IOV specification).
+\end{enumerate}
+
 =C2=A0\section{Structure Specifications}\label{sec:Structure Specification=
s}

MST/Jason/Cornelia,

can you add some Reviewed-By signatures if the above is agreed ?



>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>

