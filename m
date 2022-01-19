Return-Path: <virtio-comment-return-2597-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 19 Jan 2022 11:34:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220119112059-mutt-send-email-mst@kernel.org>
References: <20220114225032.290762-1-mst@redhat.com>
 <20220119132319.5ee3821d.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20220119132319.5ee3821d.pasic@linux.ibm.com>
Subject: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature negotiation
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 19, 2022 at 01:23:19PM +0100, Halil Pasic wrote:
> On Fri, 14 Jan 2022 17:50:51 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > Subject: virtio: clarify feature negotiation
> 
> This is in my opinion more of an incompatible change that a
> clarification, but since the commit message does not constitute a part
> of the standard, it does not matter that much.
> [..]
> 
> > @@ -298,10 +298,10 @@ \section{Device Configuration Space}\label{sec:Basic Facilities of a Virtio Devi
> >  \end{note}
> >  
> >  \devicenormative{\subsection}{Device Configuration Space}{Basic Facilities of a Virtio Device / Device Configuration Space}
> > -The device MUST allow reading of any device-specific configuration
> > +The device SHOULD allow reading of any device-specific configuration
> >  field before FEATURES_OK is set by the driver.  This includes fields which are
> > -conditional on feature bits, as long as those feature bits are offered
> > -by the device.
> > +conditional on feature bits, as long as those feature bits have
> > +been acknowledged by the driver.
> 
> "Those feature bits have been acknowledged by the driver" is new
> terminology. IMHO we should have a precise definition
> of "feature bit is acknowledged".
> 
> Currently "acknowledge features" means "write features".
> 
> 
> >  
> >  \subsection{Legacy Interface: A Note on Device Configuration Space endian-ness}\label{sec:Basic Facilities of a Virtio Device / Device Configuration Space / Legacy Interface: A Note on Configuration Space endian-ness}
> >  
> > @@ -500,8 +500,13 @@ \section{Device Initialization}\label{sec:General Initialization And Device Oper
> >  
> >  \item\label{itm:General Initialization And Device Operation /
> >  Device Initialization / Read feature bits} Read device feature bits, and write the subset of feature bits
> > -   understood by the OS and driver to the device.  During this step the
> > -   driver MAY read (but MUST NOT write) the device-specific configuration fields to check that it can support the device before accepting it.
> > +   understood by the OS and driver to the device.  During this
> > +   step, after writing the subset of feature bits to the device the
> > +   driver MAY read (but MUST NOT write) the device-specific
> > +   configuration fields to validate that it can support the device
> > +   before accepting it. The driver MAY then repeatedly modify the
> > +   subset as appropriate, write the new subset and repeat the
> > +   validation, any number of times.
> 
> IMHO don't have an exact definition of what "MAY read device-specific
> configuration field means". To me, "may read" does not automatically
> imply that what was read can be interpreted, is valid and meaningful.

Let's say "MAY read (and use)" - is that clear enough?

> For example there was no harm in reading MTU without having the
> F_VERSION_1 feature acknowledged before. We did not end up in undefined
> behavior land, the read_config operation did not blow up in our face,
> and the field was also "there" if the corresponding feature was offered.
> The only trouble was that one could not interpret the value of the field,
> because one could not tell is it big or little endian.
> 
> IMHO, we want to accomplish, readable, interpretible, valid and
> meaningful, before the feature has been negotiated by setting
> FEATURES_OK.
> 
> I see a couple of potential problems with this:
> 1) The set of acknowledged features may be invalid! For example may end
> up with feature B acknowledged and feature B not acknowledged, when
> B depends on A. Before "acknowledge" we used to be safe, because the
> device would reject FEATURES_OK.

right. but for reading config fields it's probably enough in practice.

> 2) In theory, we could have union-type conditional fields. To demonstrate
> what I mean here is a stupid example:
> struct ThermometherConfig {
> union {
> u16 temp_in_kelvin;
> u16 temp_in_celsius;
> u16 temp_in_farenheit;
> } temp;
> };
> where kelvin is the default, but you can get Celsius or Fahrenheit
> depending on mutex feature bits.
> This also used to be and still is safe after the features have been
> negotiated, but with "acknowledged" there is trouble when both the
> features are set.

something to worry about in the future but are there cases like
this in present? should we worry?

> 3) Features are written in 32 bit chunks. My guess is that what we
> want for "features acknowledged is": driver has written each chunk it
> knows about at least once. Of course, the question arises, what should
> the device do if config is read before that happens.

we are lucky that at present it's just mtu of the net device :).


> 4) It is pretty obvious to me, that after "features have been
> acknowledged", we want the driver to read the very same config as
> if we were in "features have been negotiated" state. The only  difference
> we want is, that the features must not be "frozen", i.e. the driver
> should still be able to modify the features.

I can add that, ok.

> 5) It ain't clear to me when is the driver supposed to assume that
> "the features have been acknowledged". I.e. that the expected changes
> have taken effect. For PCI, as far as I remember, they have this write it
> and then read it back drill to force side-effects. Would we have to do
> something like this. I think for FEATURES_OK we have that stuff clearly
> specified.

Hmm good point.  normally reads do not bypass writes, so you can write
features and then read config, should work.  only exception is when they
are different types e.g.  in theory features could be in IO and config
in memory.  however I think reads from different types of memory can be
reordered anyway, so that config isn't really legal.  I'll poke at the
pci spec some more to refresh my memory on this. 

> I don't know if that would be viable, but introducing a FEATURES_ACK
> status bit would IMHO resolve a bunch of these potential problems, and
> would also serve as a clear trigger for stuff like vhost (to flush
> features)

Right. With this proposal I think basically a config read
flushes features. Which isn't too bad ...

> The only problem, that would remain is that IMHO this is still
> fundamentally a change that effectively breaks compatibility. IMHO
> "features acknowledged" is essentially a new feature, which enables
> a sane use of the config space before FEATURES_OK. But we can't guard it
> with a feature bit, because the snake would just bite its tail. I'm
> fine with going down this route. It is just that I would like to be
> completely transparent about this.

well kind of. But I think the nice thing about it and the reason
I structured it this way and not as a complete new status bit
is that it really matches pretty well what the existing
body of code does, e.g. we don't need any qemu changes at all,
and most linux and windows drivers except for network with
the MTU thing are also good to go.

> Please also see my other mail!
> 
> Thank you  for tackling this! I highly appreciate it!
> 
> Regards,
> Halil
> 
> [..]


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

