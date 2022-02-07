Return-Path: <mst@redhat.com>
Date: Mon, 7 Feb 2022 05:39:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 1/4] Add virtio Admin virtqueue
Message-ID: <20220207052843-mutt-send-email-mst@kernel.org>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
 <20220203075716.11684-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20220203075716.11684-2-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 03, 2022 at 09:57:13AM +0200, Max Gurtovoy wrote:
> +\begin{lstlisting}
> +struct virtio_admin_cmd {
> +        /* Device-readable part */
> +        u16 command;
> +        u8 command_specific_data[];
> +
> +        /* Device-writable part */
> +        u8 status;
> +        u8 command_specific_error;
> +        u8 command_specific_result[];
> +};
> +\end{lstlisting}

ok this abstraction is an improvement, thanks!

What I'd like to see is moving a bit more format to this generic structure.

From what I could gather, some commands affect a group as a whole, and
some commands just a single member of the group. We could have a
"destination" field for that, and a special "all of the group"
destination for commands affecting the whole group.


Next, trying to think about scalable iov extensions. So we
will have groups of VFs and then SFs as the next level.
How does one differentiate between the two?
Maybe reserve a field for "destination type"?


The point of all this is to allow making sense of commands and
e.g. virtualizing them for nested virt without necessarily
knowing all of the detail about the specific command.

-- 
MST

