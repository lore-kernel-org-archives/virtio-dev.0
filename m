Return-Path: <virtio-dev-return-11776-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B0AC761A6
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 10:05:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C53117C318
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 10:05:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5AA4698658D
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Mar 2023 10:05:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D226898628D; Mon, 27 Mar 2023 10:05:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5543298627E
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Mar 2023 10:04:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1EQLk5TGN4yJtDCoTqveow-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679911440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zyluTO2CKgwVmo9/MMdMDdCuNb7gyjYN+zpVURUJf8=;
        b=3oEKN8Mzj3Y8GHA96txscaYvOk4E4jZa2YwOCHQHu5mxHiT27x8z2Dz8+o0KtAkGnb
         eY8DeKr6GduRxAaBZF0xahL//MSiUqdVe1k8KllqZdCaP5ZENSKbKbBJELVuIYa9DRRo
         4kuFl9rl6kmYk3NZ4fOe5IHM8lYlK9t8APO88w2IjDNGDbOyXwxm1aZPwO8wP4WbR/AN
         uqzdUX8GSh3ur2BL1rluKCXvAMBl/bQ9nsorUr4Uoo15T/lf6UI9CIApG3NYy4sMD3O6
         gSZNTx+ePuwHVepkj1LH8sijx6CwrrNzMav34qicuAb8ZAxAQ+r0ObyZDNRtbsZrNX6c
         VCXw==
X-Gm-Message-State: AAQBX9ecY+SEJ0nuInGL4yrmYVnpVhyPCh+fXCA6iNMJoogQC296Bvbb
	ZKA4gTSNn68gHzfTcFqVBDpgsuHL4KDDJajyguLGfwDu+E5kaCc3rq8xZV02eOjnTW09kz2yWWR
	QMzvJeMNToX2X2VYUB3iefUndjoZ3
X-Received: by 2002:ac8:5a93:0:b0:3e4:e80b:4613 with SMTP id c19-20020ac85a93000000b003e4e80b4613mr4979405qtc.2.1679911439749;
        Mon, 27 Mar 2023 03:03:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350bRJqLR4n4NKRu42QX7cZqKXX8094U5gpekgW59UVQe4L/vu3mVXZ1yZBSSgD0Ao7BTriOs4Q==
X-Received: by 2002:ac8:5a93:0:b0:3e4:e80b:4613 with SMTP id c19-20020ac85a93000000b003e4e80b4613mr4979376qtc.2.1679911439465;
        Mon, 27 Mar 2023 03:03:59 -0700 (PDT)
Date: Mon, 27 Mar 2023 12:03:53 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, pasic@linux.ibm.com, 
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, 
	Jiri Pirko <jiri@nvidia.com>
Message-ID: <sfu7ficnxkfnjrpbl4mnc3lwanrcocxxnoegk7smwy5a4g3jtf@hgh3e3ex4hxv>
References: <20230324010432.280330-1-parav@nvidia.com>
 <20230324010432.280330-5-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230324010432.280330-5-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v6 4/8] transport-mmio: Refer to the vq
 by its number

On Fri, Mar 24, 2023 at 04:04:28AM +0300, Parav Pandit wrote:
>Currently specification uses virtqueue index and
>number interchangeably to refer to the virtqueue.
>
>Instead refer to it by its number.
>
>Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
>Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>Signed-off-by: Parav Pandit <parav@nvidia.com>
>---
> transport-mmio.tex | 14 ++++++--------
> 1 file changed, 6 insertions(+), 8 deletions(-)
>
>diff --git a/transport-mmio.tex b/transport-mmio.tex
>index 3047633..f9b3a34 100644
>--- a/transport-mmio.tex
>+++ b/transport-mmio.tex
>@@ -108,7 +108,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>     bits accessible by writing to \field{DriverFeatures}.
>   }
>   \hline
>-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
>+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
>     Writing to this register selects the virtual queue that the
>     following operations on \field{QueueSizeMax},
>     \field{QueueSize}, \field{QueueReady},

Maybe we can also remove `index` from the last sentence in this section.
I mean something like this:

--- a/transport-mmio.tex
+++ b/transport-mmio.tex
@@ -113,8 +113,8 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
      following operations on \field{QueueSizeMax},
      \field{QueueSize}, \field{QueueReady},
      \field{QueueDescLow}, \field{QueueDescHigh}, \field{QueueDriverlLow}, \field{QueueDriverHigh},
-    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to. The index
-    number of the first queue is zero (0x0).
+    \field{QueueDeviceLow}, \field{QueueDeviceHigh} and \field{QueueReset} apply to.
+    The number of the first queue is zero (0x0).
    }
    \hline
    \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%

Thanks,
Stefano

>@@ -149,7 +149,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>     there are new buffers to process in a queue.
>
>     When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>-    the value written is the queue index.
>+    the value written is the queue number.
>
>     When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
>     the \field{Notification data} value has the following format:
>@@ -363,8 +363,7 @@ \subsubsection{Virtqueue Configuration}\label{sec:Virtio Transport Options / Vir
> The driver will typically initialize the virtual queue in the following way:
>
> \begin{enumerate}
>-\item Select the queue writing its index (first queue is 0) to
>-   \field{QueueSel}.
>+\item Select the queue writing its number to \field{QueueSel}.
>
> \item Check if the queue is not already in use: read \field{QueueReady},
>    and expect a returned value of zero (0x0).
>@@ -392,7 +391,7 @@ \subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Option
>
> When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
> the driver sends an available buffer notification to the device by writing
>-the 16-bit virtqueue index
>+the 16-bit virtqueue number
> of the queue to be notified to \field{QueueNotify}.
>
> When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
>@@ -470,7 +469,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>     (see QueuePFN).
>   }
>   \hline
>-  \mmioreg{QueueSel}{Virtual queue index}{0x030}{W}{%
>+  \mmioreg{QueueSel}{Virtual queue number}{0x030}{W}{%
>     Writing to this register selects the virtual queue that the
>     following operations on the \field{QueueSizeMax},
>     \field{QueueSize}, \field{QueueAlign}
>@@ -550,8 +549,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>
> The virtual queue is configured as follows:
> \begin{enumerate}
>-\item Select the queue writing its index (first queue is 0) to
>-   \field{QueueSel}.
>+\item Select the queue writing its number to \field{QueueSel}.
>
> \item Check if the queue is not already in use: read \field{QueuePFN},
>    expecting a returned value of zero (0x0).
>-- 
>2.26.2
>
>
>This publicly archived list offers a means to provide input to the
>OASIS Virtual I/O Device (VIRTIO) TC.
>
>In order to verify user consent to the Feedback License terms and
>to minimize spam in the list archive, subscription is required
>before posting.
>
>Subscribe: virtio-comment-subscribe@lists.oasis-open.org
>Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
>List help: virtio-comment-help@lists.oasis-open.org
>List archive: https://lists.oasis-open.org/archives/virtio-comment/
>Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
>List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
>Committee: https://www.oasis-open.org/committees/virtio/
>Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

