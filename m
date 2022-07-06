Return-Path: <virtio-comment-return-3214-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <d2e4fd9d-805a-c65a-8faa-9f4e210214a4@nvidia.com>
Date: Wed, 6 Jul 2022 15:01:14 +0300
References: <20220426225824.5918-2-mgurtovoy@nvidia.com>
 <20220515112412-mutt-send-email-mst@kernel.org>
 <b2239b43-a542-2d54-ecb2-86c0f4e35dd0@nvidia.com> <87o7zvezkc.fsf@redhat.com>
 <152fa52f-23c3-b222-68f6-db42b4231144@nvidia.com>
 <CACGkMEsLRf+6PR8s0Vo2cv4ScMLBECtY+zDC2TSuov5NtPJVHQ@mail.gmail.com>
 <20220602024254-mutt-send-email-mst@kernel.org>
 <58349984-d638-31af-82e5-8cb0fff6b0fb@nvidia.com>
 <20220628144422-mutt-send-email-mst@kernel.org>
 <5db67816-b377-0367-0b47-72f3024f004f@nvidia.com>
 <20220706074142-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220706074142-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Subject: Re: [virtio-comment] Re: [PATCH v5 1/7] Introduce device group
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Ariel Adam <aadam@redhat.com>, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


On 7/6/2022 2:42 PM, Michael S. Tsirkin wrote:
> On Wed, Jul 06, 2022 at 02:25:52PM +0300, Max Gurtovoy wrote:
>>> maybe add here "devices of this type use the Virtio PCI transport
>>> (link)"
>>>
>>> I am not sure. Maybe we want a section about SR-IOV generally,
>>> with mentions of the feature bit and the group type.
>>> For now I think what you have is enough.
>> Ok.
>>
>> So for now we won't=C2=A0 add this.
> Well adding a link can't hurt.

Ok.

Can you review the bellow please ? reviewed-by will be great..

diff --git a/introduction.tex b/introduction.tex
index aa9ec1b..c9ca978 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -156,6 +156,21 @@ \subsection{Transition from earlier specification=20
drafts}\label{sec:Transition f
 =C2=A0sections tagged "Legacy Interface" in the section title.
 =C2=A0These highlight the changes made since the earlier drafts.

+\subsection{Device group}\label{sec:Introduction / Terminology / Device=20
group}
+
+A device group includes one or more virtio devices.
+Each virtio device has a unique group member identifier=20
(group_member_id) within a device group. A valid group member identifier
+is a 64-bit field in the range of 0x0 - 0xFFFFFFFFFFFFFFF0. Member=20
identifier 0xFFFFFFFFFFFFFFFF is a value that refers to all devices in a
+device group and isn't a valid group member identifier.
+
+For now, the supported device groups are:
+\begin{enumerate}
+\item SR-IOV type - this group includes a virtio PCI SR-IOV physical=20
function (PF) and all its virtual functions (VFs).
+For this group type, the PF device has group member identifier of 0.=20
Each VF has a group member identifier matching it's VF number
+(according to PCI Express Base Specification, Single Root I/O=20
Virtualization and Sharing chapter). Devices that are members in this=20
group use
+the Virtio PCI transport (for more details see \ref{sec:Virtio=20
Transport Options / Virtio Over PCI Bus}).
+\end{enumerate}
+
 =C2=A0\section{Structure Specifications}\label{sec:Structure Specification=
s}

 =C2=A0Many device and driver in-memory structure layouts are documented us=
ing



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

