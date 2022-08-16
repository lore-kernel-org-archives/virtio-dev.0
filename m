Return-Path: <virtio-comment-return-3384-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Message-ID: <12d6a970-065c-59a2-d1c9-97a35809a8d8@nvidia.com>
Date: Wed, 17 Aug 2022 01:53:01 +0300
References: <20220812171841.12183-1-mst@redhat.com>
 <20220812171841.12183-8-mst@redhat.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220812171841.12183-8-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH RFC v7 7/8] admin: document that structures can be shorter
 or longer
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/12/2022 8:19 PM, Michael S. Tsirkin wrote:
> ensures forward and backward compatibility as long as
> we tuck new structures at the end.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   admin.tex | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/admin.tex b/admin.tex
> index a0008c7..99b6c2a 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -136,6 +136,12 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
>   holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
>   \field{command_specific_error} value is undefined and should be ignored by the driver.
>   
> +It is legal for the driver to submit commands with device-writeable and
> +device-readable structures both shorter and longer than what
> +is described in this specification. Device silently truncates the
> +structures to the shorter of the two (submitted by driver and
> +described in this specification).
> +

Why not limit this to only allow submitting longer structure provided by 
the driver ?

If the structures are shorter, return some error code that we will 
define (VIRTIO_ADMIN_STATUS_READABLE_DATA_SHORT, 
VIRTIO_ADMIN_STATUS_WRITABLE_DATA_SHORT).

Shorter data buffers can provide partial description to the device.

I'm trying not to restrict ourselves with this definition.

Driver that will start getting weird errors will not know what to do and 
why something went wrong.

>   \section{Administration Virtqueue}\label{sec:Basic Facilities of a Virtio Device / Group Administration Virtqueues}
>   
>   An administration virtqueue of a parent device is used to submit

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

