Return-Path: <virtio-comment-return-3713-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230101180824.325172-20-parav@nvidia.com>
References: <20230101180824.325172-1-parav@nvidia.com>
 <20230101180824.325172-20-parav@nvidia.com>
Date: Mon, 09 Jan 2023 14:11:28 +0100
Message-ID: <87v8lfdf9b.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v1 19/20] virtio-gpio: Maintain gpio
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
>  conformance.tex                               | 21 +------------------
>  content.tex                                   |  2 +-
>  .../virtio-gpio/device-conformance.tex        |  9 ++++++++
>  .../virtio-gpio/device.tex                    |  0
>  .../virtio-gpio/driver-conformance.tex        |  9 ++++++++
>  5 files changed, 20 insertions(+), 21 deletions(-)
>  create mode 100644 device-types/virtio-gpio/device-conformance.tex
>  rename virtio-gpio.tex => device-types/virtio-gpio/device.tex (100%)
>  create mode 100644 device-types/virtio-gpio/driver-conformance.tex

(...)

> @@ -251,16 +242,6 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \import{device-types/virtio-mem/}{device-conformance}
>  \import{device-types/virtio-scmi/}{device-conformance}
>  
> -\conformance{\subsection}{GPIO Device Conformance}\label{sec:Conformance / Device Conformance / GPIO Device Conformance}
> -
> -A General Purpose Input/Output (GPIO) device MUST conform to the following
> -normative statements:
> -
> -\begin{itemize}
> -\item \ref{devicenormative:Device Types / GPIO Device / requestq Operation}
> -\item \ref{devicenormative:Device Types / GPIO Device / eventq Operation}
> -\end{itemize}
> -

Missing

\import{device-types/virtio-gpio/}{device-conformance}

>  \conformance{\subsection}{PMEM Device Conformance}\label{sec:Conformance / Device Conformance / PMEM Device Conformance}
>  
>  A PMEM device MUST conform to the following normative statements:


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

