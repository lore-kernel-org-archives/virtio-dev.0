Return-Path: <viresh.kumar@linaro.org>
Date: Thu, 29 Jul 2021 11:17:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] virtio: i2c: Allow buffer less transactions
Message-ID: <20210729054712.aw76luyq7ajso35v@vireshk-i7>
References: <cd02a45c16631d92d864fbf432bf0b2865b7de12.1627017387.git.viresh.kumar@linaro.org>
 <7c74b6aa-5d1d-8ab1-b4ca-e1f9df8b6605@intel.com>
MIME-Version: 1.0
In-Reply-To: <7c74b6aa-5d1d-8ab1-b4ca-e1f9df8b6605@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jie Deng <jie.deng@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 29-07-21, 13:39, Jie Deng wrote:
> I removed this flag from the initial version according to Michael's
> suggestion by asking
> 
> the device take the information from the virtio descriptor. But it seems we
> need this
> 
> flag now for zero-length request since buf become optional.

Right.
 
> Well, then can we also add a flag to mark the zero-length request.
> 
> I think it will be convenient for backend developers.

Hmm, I think that information is already present at the device since
only two elements will be present in the received request, one out
buffer and one in buffer. And since the middle (data) buffer is not
present, the device can easily know that it is a zero-length request.

I don't see a real advantage of adding a flag for this.
 
> >   The final \field{status} byte of the request is written by the device: either
> >   VIRTIO_I2C_MSG_OK for success or VIRTIO_I2C_MSG_ERR for error.
> > @@ -103,27 +102,27 @@ \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Ada
> >   #define VIRTIO_I2C_MSG_ERR    1
> >   \end{lstlisting}
> > -If ``length of \field{read_buf}''=0 and ``length of \field{write_buf}''>0,
> > -the request is called write request.
> > +If \field{VIRTIO_I2C_FLAGS_M_RD} bit is set in the \field{flags}, then the
> > +request is called a read request.
> > -If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''=0,
> > -the request is called read request.
> > +If \field{VIRTIO_I2C_FLAGS_M_RD} bit is unset in the \field{flags}, then the
> > +request is called a write request.
> > -If ``length of \field{read_buf}''>0 and ``length of \field{write_buf}''>0,
> > -the request is called write-read request. It means an I2C write segment followed
> > -by a read segment. Usually, the write segment provides the number of an I2C
> > -controlled device register to be read.
> > +The \field{buf} is optional and may not be present for some of the requests,
> > +like SMBus Quick.
> 
> 
> Can we add some words to explain buf is optional because it is *zero-length*
> request ?

Yeah, I can add that keyword in the spec. Makes sense.

> I think zero-length is clearer than SMBus Quick.

+1.

-- 
viresh

