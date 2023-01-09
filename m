Return-Path: <virtio-comment-return-3710-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230101180824.325172-14-parav@nvidia.com>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230101180824.325172-14-parav@nvidia.com>
Date: Mon, 09 Jan 2023 13:48:27 +0100
Message-ID: <874jszeuw4.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v1 13/20] virtio-rpmb: Maintain rpmb
 device spec in separate directory
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Jan 01 2023, Parav Pandit <parav@nvidia.com> wrote:

> Place device specification, its driver and device
> conformance into its own directory to have self contained device
> specification.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v0->v1:
> - new patch
> ---
>  conformance.tex                               | 23 ++-----------------
>  content.tex                                   |  1 -
>  .../virtio-rpmb/device-conformance.tex        | 13 +++++++++++
>  .../virtio-rpmb/device.tex                    |  0
>  .../virtio-rpmb/driver-conformance.tex        |  7 ++++++
>  5 files changed, 22 insertions(+), 22 deletions(-)
>  create mode 100644 device-types/virtio-rpmb/device-conformance.tex
>  rename virtio-rpmb.tex => device-types/virtio-rpmb/device.tex (100%)
>  create mode 100644 device-types/virtio-rpmb/driver-conformance.tex
>

(...)

> diff --git a/content.tex b/content.tex
> index a486e36..13a2a94 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3014,7 +3014,6 @@ \chapter{Device Types}\label{sec:Device Types}
>  \import{device-types/virtio-crypto/}{device}
>  \import{device-types/virtio-vsock/}{device}
>  \import{device-types/virtio-fs/}{device}
> -\input{virtio-rpmb.tex}

This is missing

\import{device-types/virtio-rpmb/}{device}

(I noticed broken references when building with the patches applied)

>  \input{virtio-iommu.tex}
>  \input{virtio-sound.tex}
>  \input{virtio-mem.tex}


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

