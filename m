Return-Path: <virtio-dev-return-10458-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38E6E986292
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Jan 2023 13:05:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230101180824.325172-16-parav@nvidia.com>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230101180824.325172-16-parav@nvidia.com>
Date: Mon, 09 Jan 2023 14:05:27 +0100
Message-ID: <871qo3eu3s.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v1 15/20] virtio-sound: Maintain sound
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
>  conformance.tex                               | 32 +------------------
>  content.tex                                   |  2 +-
>  .../virtio-sound/device-conformance.tex       | 16 ++++++++++
>  .../virtio-sound/device.tex                   |  0
>  .../virtio-sound/driver-conformance.tex       | 13 ++++++++
>  5 files changed, 31 insertions(+), 32 deletions(-)
>  create mode 100644 device-types/virtio-sound/device-conformance.tex
>  rename virtio-sound.tex => device-types/virtio-sound/device.tex (100%)
>  create mode 100644 device-types/virtio-sound/driver-conformance.tex

(...)

> @@ -290,23 +277,6 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \import{device-types/virtio-rpmb/}{device-conformance}
>  \import{device-types/virtio-iommu/}{device-conformance}
>  
> -\conformance{\subsection}{Sound Device Conformance}\label{sec:Conformance / Device Conformance / Sound Device Conformance}
> -
> -A sound device MUST conform to the following normative statements:
> -
> -\begin{itemize}
> -\item \ref{devicenormative:Device Types / Sound Device / Device Operation / Jack Information}
> -\item \ref{devicenormative:Device Types / Sound Device / Device Operation / PCM Stream Information}
> -\item \ref{devicenormative:Device Types / Sound Device / Device Operation / PCM Stream Parameters}
> -\item \ref{devicenormative:Device Types / Sound Device / Device Operation / PCM Stream Release}
> -\item \ref{devicenormative:Device Types / Sound Device / Device Operation / PCM Output Stream}
> -\item \ref{devicenormative:Device Types / Sound Device / Device Operation / PCM Input Stream}
> -\item \ref{devicenormative:Device Types / Sound Device / Device Operation / Channel Map Information}
> -\item \ref{devicenormative:Device Types / Sound Device / Device Operation / Control Element Information}
> -\item \ref{devicenormative:Device Types / Sound Device / Device Operation / Control Element Metadata}
> -\item \ref{devicenormative:Device Types / Sound Device / Device Operation / Control Element Notifications}
> -\end{itemize}
> -

Missing

\import{device-types/virtio-sound/}{device-conformance}

>  \conformance{\subsection}{Memory Device Conformance}\label{sec:Conformance / Device Conformance / Memory Device Conformance}
>  
>  A memory device MUST conform to the following normative statements:


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

