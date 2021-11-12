Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20211111185812.2326093-1-eperezma@redhat.com> <20211111185812.2326093-2-eperezma@redhat.com>
In-Reply-To: <20211111185812.2326093-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Nov 2021 11:46:38 +0800
Message-ID: <CACGkMEuLBC8DFu21=EvgSkixRgybvvjGtcGU80mqK+Fpoe72vQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] content: Explain better the status clearing bits
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, virtio-comment@lists.oasis-open.org, mst <mst@redhat.com>, Alexander Mikheev <amikheev@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Bodong Wang <bodong@nvidia.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 12, 2021 at 2:59 AM Eugenio P=C3=A9rez <eperezma@redhat.com> wr=
ote:
>
> The spec tells that "The driver MUST NOT clear a device status bit", but
> a device using PCI transport reset a virtio device writing 0 to device
> status. In some way, that is to clear all its bits.
>
> Instead of add an exception, tell explicitely the status bits that
> the driver cannot clear anytime in a normal operation, so conformant
> device and drivers keeps being conformant.
>
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---
>  content.tex | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 5d112af..2aa3006 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -60,9 +60,10 @@ \section{\field{Device Status} Field}\label{sec:Basic =
Facilities of a Virtio Dev
>  initialization sequence specified in
>  \ref{sec:General Initialization And Device Operation / Device
>  Initialization}.
> -The driver MUST NOT clear a
> -\field{device status} bit.  If the driver sets the FAILED bit,
> -the driver MUST later reset the device before attempting to re-initializ=
e.
> +The driver MUST NOT clear ACKNOWLEDGE, DRIVER, DRIVER_OK, FEATURES_OK or
> +DEVICE_NEEDS_RESET bits of \field{device status}, except if resetting th=
e whole
> +device.

Any reason for using blacklist here? I guess it is used for patch 2
(introduce the bit that can be cleared?).

Thanks

> If the driver sets the FAILED bit, the driver MUST later reset the
> +device before attempting to re-initialize.
>
>  The driver SHOULD NOT rely on completion of operations of a
>  device if DEVICE_NEEDS_RESET is set.
> --
> 2.27.0
>

