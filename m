Return-Path: virtio-dev-return-5435-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3FF0985B66
	for <virtio-dev@lists.oasis-open.org>; Wed, 13 Feb 2019 16:47:31 +0000 (UTC)
References: <20190213063322.25099-1-stefanha@redhat.com>
 <20190213063322.25099-2-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77591e8b-5147-fa0f-27f3-a1cb94c62550@redhat.com>
Date: Wed, 13 Feb 2019 17:47:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190213063322.25099-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH v2 1/2] content: add virtio file system
 device
To: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: Miklos Szeredi <mszeredi@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Sage Weil <sweil@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 13/02/19 07:33, Stefan Hajnoczi wrote:
> +Notifications are different from normal requests because they only contain
> +device writable fields.  The driver sends notification replies on one of the
> +request queues.  The format of notification requests is as follows:
> +
> +\begin{lstlisting}
> +struct virtio_fs_notification_req {
> +        // Device-writable part
> +        struct fuse_out_header out;
> +        u8 dataout[];
> +};
> +\end{lstlisting}
> +
> +\field{out} is the completion header common to all types of FUSE requests.  The
> +\field{out.unique} field is 0 and the \field{out.error} field contains a
> +FUSE_NOTIFY_* code.
> +
> +\field{dataout} consists of request-specific data, if any.  This is identical
> +to the data written to the /dev/fuse device by a FUSE daemon.
> +

What happens if notifications are lost because no request was there?
virtio-scsi has a flag for that, would it make sense to add it here too?

Paolo

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

