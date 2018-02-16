Return-Path: virtio-return-2906-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 16 Feb 2018 17:46:21 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180216174621.1d1a8226.cohuck@redhat.com>
In-Reply-To: <20180216092643-mutt-send-email-mst@kernel.org>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
	<20180216092643-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v8 15/16] conformance: link the new conformance clause
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 16 Feb 2018 09:26:43 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  conformance.tex | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/conformance.tex b/conformance.tex
> index 55d17b4..e4efe33 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -38,6 +38,7 @@ A driver MUST conform to the following normative statements:
>  \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table}
>  \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
>  \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Interrupt Suppression}
> +\item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Available Ring}
>  \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
>  \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}
>  \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Updating idx}

This updates another patch where that was missing?

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

