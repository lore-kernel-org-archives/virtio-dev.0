Return-Path: <virtio-dev-return-10539-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81C60986364
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jan 2023 10:52:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230110230358.528098-20-parav@nvidia.com>
References: <20230110230358.528098-1-parav@nvidia.com>
 <20230110230358.528098-20-parav@nvidia.com>
Date: Wed, 11 Jan 2023 11:52:03 +0100
Message-ID: <87y1q9wdgs.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3 19/20] virtio-gpio: Maintain gpio device spec in
 separate directory
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 11 2023, Parav Pandit <parav@nvidia.com> wrote:

> Place device specification, its driver and device
> conformance into its own directory to have self contained device
> specification.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/153
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
> changelog:
> v2->v3:
> - file name changed from device.tex to description.tex
> - use input instead of import to insert a file
> v1->v2:
> - added missing device conformance reference
> v0->v1:
> - new patch
> ---
>  conformance.tex                               | 22 ++-----------------
>  content.tex                                   |  4 ++--
>  .../virtio-gpio/description.tex               |  0
>  .../virtio-gpio/device-conformance.tex        |  9 ++++++++
>  .../virtio-gpio/driver-conformance.tex        |  9 ++++++++
>  5 files changed, 22 insertions(+), 22 deletions(-)
>  rename virtio-gpio.tex => device-types/virtio-gpio/description.tex (100%)
>  create mode 100644 device-types/virtio-gpio/device-conformance.tex
>  create mode 100644 device-types/virtio-gpio/driver-conformance.tex

(...)

> diff --git a/content.tex b/content.tex
> index 977a2cd..bc67e63 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -3020,8 +3020,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \input{device-types/virtio-mem/description.tex}
>  \input{device-types/virtio-i2c/description.tex}
>  \input{device-types/virtio-scmi/description.tex}
> -\input{virtio-gpio.tex}
> -\input{virtio-pmem.tex}
> +\input{device-types/virtio-gpio/description.tex}
> +\input{device-types/virtio-pmem/description.tex}

The virtio-pmem change should have gone into the following patch?

(We don't really care about bisectability, so not a big deal; but
something that should be fixed if a respin is needed.)

>  
>  \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

