Return-Path: virtio-comment-return-1711-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20210113165746.14758-1-peter.hilber@opensynergy.com>
From: Matti Moell <Matti.Moell@opensynergy.com>
Message-ID: <8c8db0a9-3646-de28-2375-3234fc7f1dc3@opensynergy.com>
Date: Wed, 3 Feb 2021 14:45:22 +0100
MIME-Version: 1.0
In-Reply-To: <20210113165746.14758-1-peter.hilber@opensynergy.com>
Subject: Re: [virtio-comment] [PATCH] content: reserve device ID 36 for CAN
 device
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
To: virtio-comment@lists.oasis-open.org
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 13.01.21 17:57, Peter Hilber wrote:
> The CAN device sends and receives CAN (Controller Area Network)
> messages. CAN is a communication protocol used in embedded systems.
>=20
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> ---
>  content.tex | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index 620c0e2..e94469c 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2846,6 +2846,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  35         &   Watchdog \\
>  \hline
> +36         &   CAN device \\
> +\hline
>  \end{tabular}
> =20
>  Some of the devices above are unspecified by this document,
>=20

Reviewed-by: Matti M=C3=B6ll <matti.moell@opensynergy.com>
Fixes: https://github.com/oasis-tcs/virtio-spec/issues/95

I would hereby request for a vote from the TC.

Cheers,

=09=09Matti


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

