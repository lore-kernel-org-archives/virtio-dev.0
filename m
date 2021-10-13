Return-Path: <viresh.kumar@linaro.org>
Date: Wed, 13 Oct 2021 15:03:16 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 2/2] virtio: i2c: Allow zero-length transactions
Message-ID: <20211013093316.ehxp5xizo5sy52ct@vireshk-i7>
References: <cover.1634037711.git.viresh.kumar@linaro.org>
 <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
 <87bl3twa15.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87bl3twa15.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, stratos-dev@op-lists.linaro.org, Gerd Hoffmann <kraxel@redhat.com>, Arnd Bergmann <arnd@kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 13-10-21, 11:26, Cornelia Huck wrote:
> On Tue, Oct 12 2021, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > @@ -124,13 +140,23 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
> >  
> >  \drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
> >  
> > +A driver SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
> 
> Make this MUST, or maybe "MUST accept"? The central point of the feature
> flag (at least for me) was to be able to change the semantics and format
> without things breaking silently.

Right.

> I don't think we need to keep old
> driver revisions compliant?

No, we don't.

> > +
> >  A driver MUST set \field{addr} and \field{flags} before sending the request.
> >  
> >  A driver MUST set the reserved bits of \field{flags} to be zero.
> >  
> > +A driver MUST NOT send the \field{buf}, for a zero-length request.
> > +
> >  A driver MUST NOT use \field{buf}, for a read request, if the final
> >  \field{status} returned from the device is VIRTIO_I2C_MSG_ERR.
> >  
> > +A driver MUST set the \field{VIRTIO_I2C_FLAGS_M_RD} flag for a read operation,
> > +where the buffer is write-only for the device.
> > +
> > +A driver MUST NOT set the \field{VIRTIO_I2C_FLAGS_M_RD} flag for a write
> > +operation, where the buffer is read-only for the device.
> > +
> >  A driver MUST queue the requests in order if multiple requests are going to
> >  be sent at a time.
> >  
> > @@ -141,6 +167,8 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
> >  
> >  \devicenormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
> >  
> > +A device SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
> 
> Same here, I would make this "MUST offer", and simply make old device
> implementations non-compliant. The device should also reject any driver
> that does not negotiate the flag, I think?

Right.

-- 
viresh

