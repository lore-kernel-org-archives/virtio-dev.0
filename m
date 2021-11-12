Return-Path: <virtio-dev-return-8941-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E308F986490
	for <virtio-dev@lists.oasis-open.org>; Fri, 12 Nov 2021 10:35:29 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20211111185812.2326093-2-eperezma@redhat.com>
References: <20211111185812.2326093-1-eperezma@redhat.com>
 <20211111185812.2326093-2-eperezma@redhat.com>
Date: Fri, 12 Nov 2021 11:34:57 +0100
Message-ID: <87sfw1oe5q.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3 1/2] content: Explain better the status clearing bits
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, mst@redhat.com, jasowang@redhat.com
Cc: amikheev@nvidia.com, stefanha@redhat.com, shahafs@nvidia.com, oren@nvidia.com, pasic@linux.ibm.com, bodong@nvidia.com, "Dr . David Alan
 Gilbert" <dgilbert@redhat.com>, parav@nvidia.com, mgurtovoy@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 11 2021, Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:

> The spec tells that "The driver MUST NOT clear a device status bit", but
> a device using PCI transport reset a virtio device writing 0 to device

I think MMIO uses that mechanism as well?

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
> +device.  If the driver sets the FAILED bit, the driver MUST later reset =
the
> +device before attempting to re-initialize.

I think we need to distinguish "driver wants to clear a status bit" from
"driver is initiating a reset, and that transport implements that by
writing 0 to the device status". So, what about

"The driver MUST NOT clear a \field{device status} bit, except when
setting \field{device status} to 0 as a transport-specific way to
intitiate a reset."

If we introduce driver-clearable bits later, we can simply make that
"The driver MUST NOT clear a \field{device status} bit other than
NEW_BIT, ..."


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

