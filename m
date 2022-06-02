Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220426225824.5918-1-mgurtovoy@nvidia.com> <20220426225824.5918-2-mgurtovoy@nvidia.com>
 <20220515112412-mutt-send-email-mst@kernel.org> <b2239b43-a542-2d54-ecb2-86c0f4e35dd0@nvidia.com>
 <87o7zvezkc.fsf@redhat.com> <152fa52f-23c3-b222-68f6-db42b4231144@nvidia.com>
In-Reply-To: <152fa52f-23c3-b222-68f6-db42b4231144@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Jun 2022 10:21:23 +0800
Message-ID: <CACGkMEsLRf+6PR8s0Vo2cv4ScMLBECtY+zDC2TSuov5NtPJVHQ@mail.gmail.com>
Subject: Re: [virtio-comment] Re: [PATCH v5 1/7] Introduce device group
Content-Type: text/plain; charset="UTF-8"
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Ariel Adam <aadam@redhat.com>, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jun 1, 2022 at 9:44 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 5/18/2022 4:32 PM, Cornelia Huck wrote:
> > On Wed, May 18 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >
> >> Hi MST,
> >>
> >> On 5/15/2022 6:25 PM, Michael S. Tsirkin wrote:
> >>> On Wed, Apr 27, 2022 at 01:58:18AM +0300, Max Gurtovoy wrote:
> >>>> +\subsection{Device group}\label{sec:Introduction / Terminology / Device group}
> >>>> +
> >>>> +A device group includes one or more virtio devices.
> >>>> +Each virtio device has a unique virtio device id (vdev_id) within a device group. A valid vdev_id is a 64-bit field in the range of
> >>>> +0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a value that refers to all devices in a device group and isn't a valid vdev_id.
> >>>> +
> >>>> +For now, the supported device groups are:
> >>>> +\begin{enumerate}
> >>>> +\item Type 1 - A virtio PCI SR-IOV physical function (PF) and its PCI SR-IOV virtual functions (VFs). For this group type, the PF device has vdev_id that is equal to 0
> >>>> +and the VF devices have vdev_id's that are equal to their vf_number (according to the PCI SR-IOV specification).
> >>>> +\end{enumerate}
> >>>> +
> >>>>    \section{Structure Specifications}\label{sec:Structure Specifications}
> >>> In context of virtualization type 1 already refers to a specific type
> >>> of hypervisor.
> >>>
> >>> I suggest simply "SR-IOV type" - this way users do not need to remember
> >>> special terminology.
> >> This is 12 lines addition commit with simple definition.
> >>
> >> I didn't mentioned hypervisors here.
> >>
> >> I will stick to your suggestion and use name instead of numbers
> >> (although I don't understand how can a use that knows how to read spec
> >> will be confused here), but I would like Jason and Cornelia to ack on
> >> this during this review cycle.
> >>
> >> When we'll get 3 acks on this name - I'll update it for v6.
> > So, do you want to imply some kind of numbering? I don't like "Type 1",
> > either. If the type needs to be referenced in code, it should have a
> > #define or such; otherwise, "SR-IOV type" would be fine.
>
> ok I'll change it to be:
>
> diff --git a/introduction.tex b/introduction.tex
> index aa9ec1b..bba70a6 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -156,6 +156,18 @@ \subsection{Transition from earlier specification
> drafts}\label{sec:Transition f
>   sections tagged "Legacy Interface" in the section title.
>   These highlight the changes made since the earlier drafts.
>
> +\subsection{Device group}\label{sec:Introduction / Terminology / Device
> group}
> +
> +A device group includes one or more virtio devices.
> +Each virtio device has a unique virtio device id (vdev_id) within a
> device group. A valid vdev_id is a 64-bit field in the range of
> +0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a value that
> refers to all devices in a device group and isn't a valid vdev_id.
> +
> +For now, the supported device groups are:
> +\begin{enumerate}
> +\item SR-IOV type - A virtio PCI SR-IOV physical function (PF) and its
> PCI SR-IOV virtual functions (VFs). For this group type, the PF device
> has vdev_id that is equal to 0
> +and the VF devices have vdev_id's that are equal to their vf_number
> (according to the PCI SR-IOV specification).
> +\end{enumerate}
> +
>   \section{Structure Specifications}\label{sec:Structure Specifications}
>
> MST/Jason/Cornelia,
>
> can you add some Reviewed-By signatures if the above is agreed ?

If I understand this correctly, the idea of "device group" is to allow
different groups to be managed by a single admin virtqueue?

And I feel that mixing transport specific definitions in the general
admin virtqueue might not be optimal. So I wonder whether it's better
to just say this is a transport specific type. And define it in the
PCI transport part.

Thanks

>
>
>
> >
> >
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> >
>

