Return-Path: <virtio-dev-return-8609-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
Message-Id: <1630035912.9108565-1-xuanzhuo@linux.alibaba.com>
Date: Fri, 27 Aug 2021 11:45:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
In-Reply-To: <5d52037a-8755-5ff8-9a7b-3a383017a5cf@redhat.com>
Subject: Re: [virtio-dev] [PATCH] virtio: introduce VIRTIO_F_RING_RESET for
 reset queue
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 27 Aug 2021 11:41:11 +0800, Jason Wang <jasowang@redhat.com> wrote:
>
> =E5=9C=A8 2021/8/27 =E4=B8=8A=E5=8D=8811:18, Xuan Zhuo =E5=86=99=E9=81=93=
:
> > On Thu, 26 Aug 2021 12:32:34 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> >> =E5=9C=A8 2021/8/23 =E4=B8=8B=E5=8D=884:28, Xuan Zhuo =E5=86=99=E9=81=
=93:
> >>> cc jasowang@redhat.com
> >>>
> >>> On Fri, 13 Aug 2021 10:31:05 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba=
.com> wrote:
> >>>> This patch allows the driver to reset a queue individually.
> >>>>
> >>>> This is very common on general network equipment. By disabling a que=
ue,
> >>>> you can quickly reclaim the buffer currently on the queue. If necess=
ary,
> >>>> we can reinitialize the queue separately.
> >>>>
> >>>> For example, when virtio-net implements support for AF_XDP, we need =
to
> >>>> disable a queue to release all the original buffers when AF_XDP setu=
p.
> >>>> And quickly release all the AF_XDP buffers that have been placed in =
the
> >>>> queue when AF_XDP exits.
> >>>>
> >>>> Since mmio's QueueReady allows setting 0 to stop the queue, there is=
 no
> >>>> need to distinguish whether VIRTIO_F_RING_RESET is negotiated.
> >>>>
> >>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >>>> ---
> >>>>    content.tex | 11 ++++++++++-
> >>>>    1 file changed, 10 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/content.tex b/content.tex
> >>>> index 7cec1c3..70a9765 100644
> >>>> --- a/content.tex
> >>>> +++ b/content.tex
> >>>> @@ -1001,7 +1001,13 @@ \subsubsection{Common configuration structure=
 layout}\label{sec:Virtio Transport
> >>>>    After writing 0 to \field{device_status}, the driver MUST wait fo=
r a read of
> >>>>    \field{device_status} to return 0 before reinitializing the devic=
e.
> >>>>
> >>>> -The driver MUST NOT write a 0 to \field{queue_enable}.
> >>>> +If the VIRTIO_F_RING_RESET feature bit is not negotiated,
> >>>> +the driver MUST NOT write a 0 to \field{queue_enable}.
> >>>> +
> >>>> +Otherwise, if the VIRTIO_F_RING_RESET feature bit is negotiated,
> >>>> +the driver can stop using the queue by writing a 0 to \field{queue_=
enable} and
> >>>> +MUST read the value back to ensure synchronization. Then optionally=
 re-enable
> >>>> +the queue.
> >>
> >>
> >> So I think we need to clarify what did "stop" mean here. Since you're
> >> use "RESET" in the feature I guess the virtqueue state is also reset.
> >> That's fine but I'm not sure if MMIO has the similar semantic.
> >>
> >> E.g is the virtqueue state preserved during a stop and resume?
> >    "To stop using the queue the driver MUST write zero (0x0) to this Qu=
eueReady
> >    and MUST read the value back to ensure synchronization."
> >
> > Judging from the description of the spec, the more emphasis is on the s=
top of
> > the queue. It does not express whether the queue can be re-enabled.
>
>
> Yes.
>
>
> >
> > I think MMIO also adds the judgment for VIRTIO_F_RING_RESET here. If th=
is
> > function is successfully negotiated, then MMIO also supports queue rese=
t,
> > otherwise MMIO only supports stop queue.
> >
> > The "stop" I understand means the destruction of all the states of the =
entire
> > queue and the release of memory. Re-enable means reallocating the memor=
y as when
> > the device is initialized, and synchronizing this information to the de=
vice.
> > I will improve this part of the information in the next version.
> >
> > Regarding the description of the state during a stop and resume, I will=
 add it
> > in the next version.
>
>
> A question regarding to the semantic of "resume". I guess it means the
> virtqueue will start from e.g avail index 0?

Yes.

Thanks.

>
> Thanks
>
>
> >
> > Thanks.
> >
> >> Thanks
> >>
> >>
> >>>>    \subsubsection{Notification structure layout}\label{sec:Virtio Tr=
ansport Options / Virtio Over PCI Bus / PCI Device Layout / Notification ca=
pability}
> >>>>
> >>>> @@ -6672,6 +6678,9 @@ \chapter{Reserved Feature Bits}\label{sec:Rese=
rved Feature Bits}
> >>>>      transport specific.
> >>>>      For more details about driver notifications over PCI see \ref{s=
ec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initializa=
tion And Device Operation / Available Buffer Notifications}.
> >>>>
> >>>> +  \item[VIRTIO_F_RING_RESET(40)] This feature indicates
> >>>> +  that the driver can reset a queue individually.
> >>>> +
> >>>>    \end{description}
> >>>>
> >>>>    \drivernormative{\section}{Reserved Feature Bits}{Reserved Featur=
e Bits}
> >>>> --
> >>>> 2.31.0
> >>>>
> >>>>
> >>>> --------------------------------------------------------------------=
-
> >>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> >>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.or=
g
> >>>>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

