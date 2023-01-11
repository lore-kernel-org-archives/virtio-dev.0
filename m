Return-Path: <virtio-comment-return-3791-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230110230358.528098-12-parav@nvidia.com>
References: <20230110230358.528098-1-parav@nvidia.com>
 <20230110230358.528098-12-parav@nvidia.com>
Date: Wed, 11 Jan 2023 12:04:04 +0100
Message-ID: <87v8ldwcwr.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v3 11/20] virtio-vsock: Maintain socket device spec in
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
> v0->v1:
> - new patch
> ---
>  conformance.tex                               | 48 +------------------
>  content.tex                                   |  2 +-
>  .../virtio-vsock/description.tex              |  0
>  .../virtio-vsock/device-conformance.tex       |  9 ++++
>  .../virtio-vsock/driver-conformance.tex       | 10 ++++
>  5 files changed, 22 insertions(+), 47 deletions(-)
>  rename virtio-vsock.tex => device-types/virtio-vsock/description.tex (100%)
>  create mode 100644 device-types/virtio-vsock/device-conformance.tex
>  create mode 100644 device-types/virtio-vsock/driver-conformance.tex

(...)

> @@ -328,41 +318,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
>  \input{device-types/virtio-gpu/device-conformance.tex}
>  \input{device-types/virtio-input/device-conformance.tex}
>  \input{device-types/virtio-crypto/device-conformance.tex}
> -
> -\conformance{\subsection}{Crypto Device Conformance}\label{sec:Conformance / Device Conformance / Crypto Device Conformance}
> -
> -A Crypto device MUST conform to the following normative statements:
> -
> -\begin{itemize}
> -\item \ref{devicenormative:Device Types / Crypto Device / Device configuration layout}
> -\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: create session}
> -\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation / Session operation: destroy session}
> -\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / HASH Service Operation}
> -\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / MAC Service Operation}
> -\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / Symmetric algorithms Operation}
> -\item \ref{devicenormative:Device Types / Crypto Device / Device Operation / AEAD Service Operation}
> -\end{itemize}
> -=======
> -\import{device-types/virtio-network/}{device-conformance}
> -\import{device-types/virtio-block/}{device-conformance}
> -\import{device-types/virtio-console/}{device-conformance}
> -\import{device-types/virtio-entropy/}{device-conformance}
> -\import{device-types/virtio-mem-balloon/}{device-conformance}
> -\import{device-types/virtio-scsi/}{device-conformance}
> -\import{device-types/virtio-gpu/}{device-conformance}
> -\import{device-types/virtio-input/}{device-conformance}
> -\import{device-types/virtio-crypto/}{device-conformance}
> ->>>>>>> a695ea2... virtio-crypto: Maintain crypto device spec in separate directory

Instead of removing it here, better don't even add it in the
virtio-crypto patch :)


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

