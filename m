Return-Path: <virtio-comment-return-1961-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20210707043441.42361-1-jasowang@redhat.com>
References: <20210707043441.42361-1-jasowang@redhat.com>
Date: Fri, 09 Jul 2021 13:06:32 +0200
Message-ID: <87pmvreog7.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH] virtio-pci: implement VIRTIO_F_RING_STATE
Content-Type: text/plain
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, jasowang@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, mgurtovoy@nvidia.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com, dgilbert@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 07 2021, Jason Wang <jasowang@redhat.com> wrote:

> This patch is a follow up for the virtqueue state synchronization
> series to implement VIRTIO_F_RING_STATE via a dedicated capability for
> PCI transport.
>
> With the help of the STOP status bit, the virtqueue state
> synchronization for PCI should be self contained.
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  content.tex | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

(...)

> +\devicenormative{\paragraph}{General Virtqueue State}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / General Virtqueue State}
> +
> +The device MUST present at least one VIRTIO_PCI_CAP_RING_STATE
> capability if VITIO_F_RING_STATE is negotiated.

s/VITIO/VIRTIO/

Are multiple capabilities inteded to enable parallel access to multiple
virtqueues?

> +
>  \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
>  
>  Transitional devices MUST present part of configuration


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

