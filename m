Return-Path: <viresh.kumar@linaro.org>
Date: Wed, 13 Oct 2021 09:09:19 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 2/2] virtio: i2c: Allow zero-length transactions
Message-ID: <20211013033919.jybykoof526zjpsm@vireshk-i7>
References: <cover.1634037711.git.viresh.kumar@linaro.org>
 <325276eec77c6ab3bd28382386055b821754396b.1634037711.git.viresh.kumar@linaro.org>
 <CAK8P3a3GvrcjeTXfdnL=vrWSUVD2KOXa7x1Lw0+uMSzfOJarEQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3GvrcjeTXfdnL=vrWSUVD2KOXa7x1Lw0+uMSzfOJarEQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Arnd Bergmann <arnd@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jie Deng <jie.deng@intel.com>, Wolfram Sang <wsa@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jason Wang <jasowang@redhat.com>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org, Stratos Mailing List <stratos-dev@op-lists.linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12-10-21, 16:09, Arnd Bergmann wrote:
> On Tue, Oct 12, 2021 at 1:23 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +\begin{description}
> > +\item[VIRTIO_I2C_F_ZERO_LENGTH_REQUEST (0)] The device supports zero-length I2C
> > +request and \field{VIRTIO_I2C_FLAGS_M_RD} flag. It is mandatory to implement
> > +this feature.
> > +\end{description}
> 
> I'm not quite sure what it means to have a mandatory feature flag,

Cornelia suggested this option earlier:

https://lists.oasis-open.org/archives/virtio-dev/202109/msg00087.html

> or what the driver is expected to do if it finds the flag to be missing.

I think the driver is expected to fail in that case.

> Assuming this is something we do in other virtio specs, I see nothing
> wrong here though.

I am not sure if it is used anywhere else.

> > @@ -99,6 +106,15 @@ \subsubsection{Device Operation: Request Queue}\label{sec:Device Types / I2C Ada
> >  #define VIRTIO_I2C_MSG_ERR    1
> >  \end{lstlisting}
> >
> > +If \field{VIRTIO_I2C_FLAGS_M_RD} bit is set in the \field{flags}, then the
> > +request is called a read request.
> > +
> > +If \field{VIRTIO_I2C_FLAGS_M_RD} bit is unset in the \field{flags}, then the
> > +request is called a write request.
> > +
> > +The \field{buf} is optional and will not be present for a zero-length request,
> > +like SMBus Quick.
> 
> Maybe write this as
> 
> ... like the SMBus "Quick" command.

Sure.

> > @@ -124,13 +140,23 @@ \subsubsection{Device Operation: Operation Status}\label{sec:Device Types / I2C
> >
> >  \drivernormative{\subsubsection}{Device Operation}{Device Types / I2C Adapter Device / Device Operation}
> >
> > +A driver SHOULD implement the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature.
> 
> I don't think this needs to be "SHOULD", as a driver may be written to only
> talk to certain i2c clients on the device side, and they do not need zero
> length requests. Maybe this could be
> 
> "A driver MAY assume that the VIRTIO_I2C_F_ZERO_LENGTH_REQUEST
> feature is available".

The problem here is that "VIRTIO_I2C_FLAGS_M_RD" is supported only
with VIRTIO_I2C_F_ZERO_LENGTH_REQUEST feature. If the feature isn't
available, then the device/driver need to encode/decode the direction
of the transfer (read/write) to/from the permissions of the buffer.

This is exactly what we are looking to avoid here with Mandatory
feature, i.e. not to drag the old implementation around. And so it
really needs to be SHOULD instead.

-- 
viresh

