Return-Path: <mst@redhat.com>
Date: Thu, 9 Feb 2023 07:31:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3] virtio-net: Improve introductory description
Message-ID: <20230209073110-mutt-send-email-mst@kernel.org>
References: <20230209014108.209950-1-parav@nvidia.com>
 <20230209071430-mutt-send-email-mst@kernel.org>
 <877cwr6myi.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <877cwr6myi.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 09, 2023 at 01:29:57PM +0100, Cornelia Huck wrote:
> On Thu, Feb 09 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Feb 09, 2023 at 03:41:08AM +0200, Parav Pandit wrote:
> >> @@ -389,8 +392,8 @@ \subsection{Device Operation}\label{sec:Device Types / Network Device / Device O
> >>  };
> >>  \end{lstlisting}
> >>  
> >> -The controlq is used to control device features such as
> >> -filtering.
> >> +The controlq is used to control many device features described further in
> >
> > many seems subjective.
> >
> > s/many/some of the/ ?
> 
> s/many/various/ instead? That section should cover all of the device
> features controled via the control vq.

I like that.

> >
> >> +section \ref{sec:Device Types / Network Device / Device Operation / Control Virtqueue}.

