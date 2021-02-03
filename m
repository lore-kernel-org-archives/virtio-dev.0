Return-Path: virtio-comment-return-1707-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 3 Feb 2021 11:15:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20210203111532.69ee4033.cohuck@redhat.com>
In-Reply-To: <20210203084058.1910930-1-vivek.kasireddy@intel.com>
References: <20210203084058.1910930-1-vivek.kasireddy@intel.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH] virtio-dmabuf: Add specification
 details for this device
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, kraxel@redhat.com, Dongwon Kim <dongwon.kim@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed,  3 Feb 2021 00:40:58 -0800
Vivek Kasireddy <vivek.kasireddy@intel.com> wrote:

> The virtio dmabuf device provides a way to share a page backed dmabuf
> created in the Guest with the Host. The actual sharing is accomplished
> by recreating the dmabuf on the Host using the page metadata shared by
> the guest.
> 
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  conformance.tex    |  30 ++++++++++--
>  content.tex        |   3 ++
>  virtio-vdmabuf.tex | 120 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 149 insertions(+), 4 deletions(-)
>  create mode 100644 virtio-vdmabuf.tex
> 

(...)

> diff --git a/content.tex b/content.tex
> index 1ca24c1..b6ea383 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -2846,6 +2846,8 @@ \chapter{Device Types}\label{sec:Device Types}
>  \hline
>  35         &   Watchdog \\
>  \hline
> +36         &   Dmabuf device \\

Please split off reserving a device id into a separate issue that can
be voted upon independently.

Also, there was already a request on-list to reserve 36 for CAN
(although no issue has yet been opened); maybe bump the id to 37
regardless?

> +\hline
>  \end{tabular}
>  
>  Some of the devices above are unspecified by this document,

(...)


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

