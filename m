Return-Path: <virtio-dev-return-10459-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A0821986292
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Jan 2023 13:07:54 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230101180824.325172-18-parav@nvidia.com>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230101180824.325172-18-parav@nvidia.com>
Date: Mon, 09 Jan 2023 14:07:48 +0100
Message-ID: <87y1qbdfff.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v1 17/20] virtio-i2c: Maintain i2c
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
>  conformance.tex                                 | 17 +----------------
>  content.tex                                     |  2 +-
>  device-types/virtio-i2c/device-conformance.tex  |  7 +++++++
>  .../virtio-i2c/device.tex                       |  0
>  device-types/virtio-i2c/driver-conformance.tex  |  7 +++++++
>  5 files changed, 16 insertions(+), 17 deletions(-)
>  create mode 100644 device-types/virtio-i2c/device-conformance.tex
>  rename virtio-i2c.tex => device-types/virtio-i2c/device.tex (100%)
>  create mode 100644 device-types/virtio-i2c/driver-conformance.tex
>

(...)

> @@ -265,14 +258,6 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \import{device-types/virtio-iommu/}{device-conformance}
>  \import{device-types/virtio-mem/}{device-conformance}
>  
> -\conformance{\subsection}{I2C Adapter Device Conformance}\label{sec:Conformance / Device Conformance / I2C Adapter Device Conformance}
> -
> -An I2C Adapter device MUST conform to the following normative statements:
> -
> -\begin{itemize}
> -\item \ref{devicenormative:Device Types / I2C Adapter Device / Device Operation}
> -\end{itemize}
> -

Missing

\import{device-types/virtio-i2c/}{device-conformance}

>  \conformance{\subsection}{SCMI Device Conformance}\label{sec:Conformance / Device Conformance / SCMI Device Conformance}
>  
>  An SCMI device MUST conform to the following normative statements:


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

