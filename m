Return-Path: <virtio-comment-return-2590-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 19 Jan 2022 13:23:19 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Message-ID: <20220119132319.5ee3821d.pasic@linux.ibm.com>
In-Reply-To: <20220114225032.290762-1-mst@redhat.com>
References: <20220114225032.290762-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature negotiation
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, 14 Jan 2022 17:50:51 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:
> Subject: virtio: clarify feature negotiation

This is in my opinion more of an incompatible change that a
clarification, but since the commit message does not constitute a part
of the standard, it does not matter that much.
[..]

> @@ -298,10 +298,10 @@ \section{Device Configuration Space}\label{sec:Basi=
c Facilities of a Virtio Devi
>  \end{note}
> =20
>  \devicenormative{\subsection}{Device Configuration Space}{Basic Faciliti=
es of a Virtio Device / Device Configuration Space}
> -The device MUST allow reading of any device-specific configuration
> +The device SHOULD allow reading of any device-specific configuration
>  field before FEATURES_OK is set by the driver.  This includes fields whi=
ch are
> -conditional on feature bits, as long as those feature bits are offered
> -by the device.
> +conditional on feature bits, as long as those feature bits have
> +been acknowledged by the driver.

"Those feature bits have been acknowledged by the driver" is new
terminology. IMHO we should have a precise definition
of "feature bit is acknowledged".

Currently "acknowledge features" means "write features".


> =20
>  \subsection{Legacy Interface: A Note on Device Configuration Space endia=
n-ness}\label{sec:Basic Facilities of a Virtio Device / Device Configuratio=
n Space / Legacy Interface: A Note on Configuration Space endian-ness}
> =20
> @@ -500,8 +500,13 @@ \section{Device Initialization}\label{sec:General In=
itialization And Device Oper
> =20
>  \item\label{itm:General Initialization And Device Operation /
>  Device Initialization / Read feature bits} Read device feature bits, and=
 write the subset of feature bits
> -   understood by the OS and driver to the device.  During this step the
> -   driver MAY read (but MUST NOT write) the device-specific configuratio=
n fields to check that it can support the device before accepting it.
> +   understood by the OS and driver to the device.  During this
> +   step, after writing the subset of feature bits to the device the
> +   driver MAY read (but MUST NOT write) the device-specific
> +   configuration fields to validate that it can support the device
> +   before accepting it. The driver MAY then repeatedly modify the
> +   subset as appropriate, write the new subset and repeat the
> +   validation, any number of times.

IMHO don't have an exact definition of what "MAY read device-specific
configuration field means". To me, "may read" does not automatically
imply that what was read can be interpreted, is valid and meaningful.

For example there was no harm in reading MTU without having the
F_VERSION_1 feature acknowledged before. We did not end up in undefined
behavior land, the read_config operation did not blow up in our face,
and the field was also "there" if the corresponding feature was offered.
The only trouble was that one could not interpret the value of the field,
because one could not tell is it big or little endian.

IMHO, we want to accomplish, readable, interpretible, valid and
meaningful, before the feature has been negotiated by setting
FEATURES_OK.

I see a couple of potential problems with this:
1) The set of acknowledged features may be invalid! For example may end
up with feature B acknowledged and feature B not acknowledged, when
B depends on A. Before "acknowledge" we used to be safe, because the
device would reject FEATURES_OK.
2) In theory, we could have union-type conditional fields. To demonstrate
what I mean here is a stupid example:
struct ThermometherConfig {
union {
u16 temp_in_kelvin;
u16 temp_in_celsius;
u16 temp_in_farenheit;
} temp;
};
where kelvin is the default, but you can get Celsius or Fahrenheit
depending on mutex feature bits.
This also used to be and still is safe after the features have been
negotiated, but with "acknowledged" there is trouble when both the
features are set.
3) Features are written in 32 bit chunks. My guess is that what we
want for "features acknowledged is": driver has written each chunk it
knows about at least once. Of course, the question arises, what should
the device do if config is read before that happens.
4) It is pretty obvious to me, that after "features have been
acknowledged", we want the driver to read the very same config as
if we were in "features have been negotiated" state. The only  difference
we want is, that the features must not be "frozen", i.e. the driver
should still be able to modify the features.
5) It ain't clear to me when is the driver supposed to assume that
"the features have been acknowledged". I.e. that the expected changes
have taken effect. For PCI, as far as I remember, they have this write it
and then read it back drill to force side-effects. Would we have to do
something like this. I think for FEATURES_OK we have that stuff clearly
specified.

I don't know if that would be viable, but introducing a FEATURES_ACK
status bit would IMHO resolve a bunch of these potential problems, and
would also serve as a clear trigger for stuff like vhost (to flush
features)

The only problem, that would remain is that IMHO this is still
fundamentally a change that effectively breaks compatibility. IMHO
"features acknowledged" is essentially a new feature, which enables
a sane use of the config space before FEATURES_OK. But we can't guard it
with a feature bit, because the snake would just bite its tail. I'm
fine with going down this route. It is just that I would like to be
completely transparent about this.

Please also see my other mail!

Thank you  for tackling this! I highly appreciate it!

Regards,
Halil

[..]

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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

