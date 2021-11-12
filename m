Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <20211111185812.2326093-3-eperezma@redhat.com>
In-Reply-To: <20211111185812.2326093-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Nov 2021 12:18:27 +0800
Message-ID: <CACGkMEv+42=qMDHtn8vM1jG6K2rNuKWz=CLtpJqwVJ7u7WF=ZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] virtio: introduce STOP status bit
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, mst <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 12, 2021 at 2:59 AM Eugenio P=C3=A9rez <eperezma@redhat.com> wr=
ote:
>
> From: Jason Wang <jasowang@redhat.com>
>
> This patch introduces a new status bit STOP. This can be used by the
> driver to stop the device in order to safely fetch used descriptors
> status, making sure the device will not fetch new available ones.
>
> Its main use case is live migration, although it has other orthogonal
> use cases. It can be used to safely discard requests that have not been
> used: in other words, to rewind available descriptors.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

So this is much more complicated, see below.

> ---
>  content.tex | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
>
> diff --git a/content.tex b/content.tex
> index 2aa3006..9ed0d09 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -47,6 +47,13 @@ \section{\field{Device Status} Field}\label{sec:Basic =
Facilities of a Virtio Dev
>  \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
>    drive the device.
>
> +\item[STOP (16)] When VIRTIO_F_STOP is negotiated, indicates that the
> +  device has been stopped by the driver. This status bit is different
> +  from the reset since the device state is preserved.
> +
> +\item[STOP_FAILED (32)] When VIRTIO_F_STOP is negotiated, indicates that=
 the
> +  device could not stop the STOP request.
> +
>  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
>    an error from which it can't recover.
>  \end{description}
> @@ -74,11 +81,83 @@ \section{\field{Device Status} Field}\label{sec:Basic=
 Facilities of a Virtio Dev
>  recover by issuing a reset.
>  \end{note}
>
> +If VIRTIO_F_STOP has been negotiated,

"has not been" actually?

> the driver MUST NOT set or clear STOP if
> +DRIVER_OK is not set.
> +
> +If VIRTIO_F_STOP has been negotiated the driver MUST re-read the device =
status
> +to ensure the STOP or STOP_FAILED bit is set after the write. The device
> +acknowledges the new paused status setting the first, or the failure set=
ting
> +the last. Since this change may not be instantaneous, the driver MAY wai=
t for
> +the configuration change notification that the device must send after th=
e
> +change.

This is kind of tricky, it means the device can send notification
after it has been stopped. As discussed in the previous versions,
driver is freed to use timer or what ever other mechanism if it
doesn't like the busy polling. I wonder how much value we can gain
from a dedicated config interrupt. Especially consider some transport
can use transport specific interrupt (not virtio specific interrupt)
for reporting whether or not set status succeed.

>If the device sets the STOP_FAILED bit, the driver MUST clear it before
> +try new STOP attempts.

Does the device need to re-read the STOP_FAILED for synchronization? I
wonder how much we can gain from STOP_FAILED, the patch is unclear on
when that the device needs to set this bit. And driver can choose to
reset after a specific timeout anyhow.

> +
> +If VIRTIO_F_STOP has been negotiated and the device has confirmed its st=
op,
> +the driver MAY change avail_idx in the case of split virtqueue, but the =
new
> +avail_idx MUST be within used_idx and used_idx plus virtqueue size.

Any motivation for this? it looks to me it makes the feature coupled
with the virtqueue state proposal? It seems odd to allow avail change
but not the last_avail_idx change.

> +
> +If VIRTIO_F_STOP has been negotiated and the device has confirmed its st=
op,
> +the driver MAY change any descriptor.
> +
> +If VIRTIO_F_STOP has been negotiated and the device has confirmed its st=
opped,
> +the driver can resume it clearing the STOP status bit. It MUST re-read t=
he
> +device status to ensure the STOP bit is clear after the write. The devic=
e
> +acknowledges the new status clearing it. Since this change may not be
> +instantaneous, the driver MAY wait for the configuration change notifica=
tion
> +that the device must send after the change.

Do we really needs resuming? it's kind of:

1) STOP -> clear STOP

vs

2) STOP -> RESET -> DRIVER_OK

Using 2) preserve the semantic that the driver can't clear the status bit.

> +
>  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a=
 Virtio Device / Device Status Field}
>
>  The device MUST NOT consume buffers or send any used buffer
>  notifications to the driver before DRIVER_OK.
>
> +If VIRTIO_F_STOP has not been negotiated the device MUST ignore the writ=
e of
> +STOP. If the DRIVER_OK status bit is not set the device SHOULD ignore th=
e write
> +or clear of STOP.
> +
> +If VIRTIO_F_STOP has been negotiated, the device MUST finish any in flig=
ht
> +operations after the driver writes STOP.

I wonder if it's better to leave this to device to decide. E.g some
block devices may requires a very log time to finish the inflight
operations.

> Depending on the device, it can do it
> +in many ways as long as the driver can recover its normal operation if i=
t
> +resumes the device without the need of resetting it:
> +\begin{itemize}
> +\item Drain and wait for the completion of all pending requests until a
> +convenient avail descriptor. Ignore any other posterior descriptor.
> +\item Return a device-specific failure for these descriptors, so the dri=
ver
> +can choose to retry or to cancel them.

If we allow the driver to retry, we need a way to report inflight
buffers which is not supported by the spec. A way to solve this is to
make it device specific.

> +\item Mark them as done even if they are not, if the kind of device can
> +assume to lose them.

I think "make buffer used" is better than "mark them as done". And we
need a accurate definition on who is "them".

> +\end{itemize}
> +
> +If VIRTIO_F_STOP has been negotiated and it needs to fail the device sto=
p after
> +a guest's request,

It's not clear what did "a guest's request" means.

> the device MUST set the STOP_FAILED bit for the guest to
> +read it. The device MUST ignore new writes to the STOP bit until the gue=
st
> +clears STOP_FAILED.
> +
> +If VIRTIO_F_STOP has been negotiated and the guest has written the STOP =
bit,
> +and the device can pause its operation, the device MUST set the descript=
ors
> +that it has done with them as used before exposing the STOP status bit a=
s set.
> +
> +If VIRTIO_F_STOP has been negotiated, the device MUST NOT perform these =
actions
> +after exposing the STOP bit set:
> +\begin{itemize}
> +\item Read updates on the descriptor or driver area, or consume more buf=
fers.
> +\item Send any used buffer notifications to the driver.
> +\end{itemize}
> +
> +The device MUST send a configuration space change right after exposing t=
he STOP
> +or STOP_FAILED as set to the driver, and MUST NOT change configuration s=
pace or
> +send another configuration space change notification to the driver after=
wards
> +until the guest clears it.
> +
> +If VIRTIO_F_STOP has been negotiated and STOP device status flag is set,
> +the device MUST resume operation when the driver clears the STOP bit. Th=
e
> +device MUST continue reading available descriptors as if an available bu=
ffer
> +notification has reach it, starting from the last descriptor it marked a=
s used,

So I still tend to define virtqueue state as basic facility before
defining STOP. It can makes thing easier.

> +and continue the regular operation after that. The device MUST read agai=
n
> +descriptor and driver area beyond the last descriptor it marked as used =
when it
> +stopped, because the driver can change it. Device MUST set DEVICE_NEEDS_=
RESET
> +if for some reason it cannot continue.
> +
>  \label{sec:Basic Facilities of a Virtio Device / Device Status Field / D=
EVICENEEDSRESET}The device SHOULD set DEVICE_NEEDS_RESET when it enters an =
error state
>  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS=
_RESET, the device
>  MUST send a device configuration change notification to the driver.
> @@ -6694,6 +6773,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved=
 Feature Bits}
>    transport specific.
>    For more details about driver notifications over PCI see \ref{sec:Virt=
io Transport Options / Virtio Over PCI Bus / PCI-specific Initialization An=
d Device Operation / Available Buffer Notifications}.
>
> +\item[VIRTIO_F_STOP(41)] This feature indicates that the driver can
> +  stop the device.
> +  See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field=
}.
> +
>  \end{description}

So I think the patch complicate thing is various ways:

1) STOP_FAILED status bit, which seems unnecessary or even duplicated
with NEEDS_RESET
2) configuration change interrupt, looks conflict with the semantic of STOP
3) status bit clearing (resuming), a functional duplication with RESET
+ DRIVER_OK

I think we'd better to stick to the minimal set of the function to
reduce the complexity: virtqueue state + STOP bit (without clearing
and no config interrupt).

Thanks

>
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> --
> 2.27.0
>

