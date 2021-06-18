Return-Path: virtio-comment-return-1907-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20210617094122.1627-1-info@metux.net>
 <20210617094122.1627-2-info@metux.net>
 <20210617113310.6oo74e5htvmm4afr@vireshk-i7>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <c652943a-16b9-3246-460d-40896abc6f8c@metux.net>
Date: Fri, 18 Jun 2021 11:19:57 +0200
MIME-Version: 1.0
In-Reply-To: <20210617113310.6oo74e5htvmm4afr@vireshk-i7>
Subject: Re: [virtio-comment] Re: [virtio-dev] [PATCH] virtio-gpio: add formal
 specification
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: quoted-printable
To: Viresh Kumar <viresh.kumar@linaro.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Vincent Guittot <vincent.guittot@linaro.org>, Bill Mills <bill.mills@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Jason Wang <jasowang@redhat.com>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Arnd Bergmann <arnd@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On 17.06.21 13:33, Viresh Kumar wrote:

> FWIW ./makehtml.sh reported a few missing references I believe, it
> wasn't a clean build.

I'm seeing those (also w/ makepdf.sh) even in master. Since they only
appear pretty early, while the script does several xetex runs, I'd
suspect that's the usual tex behaviour:

When using xrefs, you have to do multiple runs, since it's working
linear and doesn't know the targets in the first runs. But it writes
the targets it encounters in a temporary file which is loaded in
subsequent runs - then the xrefs can be resolved and the warning goes
away. Same when using toc / index / bibliography.

>> +\begin{tabular}{|l|l|l|}
>> +    \hline
>> +    \textbf{Offset} & \textbf{Type} & \textbf{Description} \\
>> +    \hline
>> +    0x00   & u8           & version \\
>=20
> As previously mentioned by Jason as well, most of the virtio protocol
> specifications don't talk about versions but rather Features. The
> features are normally more readable than saying version is 1.0 or 2.0.

Right, but these are separate things. I believe that most future
extensions can be done by feature bits. But it seems good to have
something in reserve in case that isn't enough some day - otherwise
we'd have to allocate a new ID for that.

Finally it's just one byte in a ROM :p

> I understand from our previous discussions that you wanted to make it
> possible for this structure to be extended in the future and so kept
> the extra padding of 24 bytes. That is a right thing to do, as we may
> need to add more fields here.

I see two options:
a) add some reserve space (but with unpredictable readout data)
b) increase the size in future versions

I'll have to check back w/ my HW folks whether an reserved but
unassigned address space adds a notable amount of gates. There might
be some special handling necessary, since we don't wanna end up in
faults when a fully valid driver reads out more rom space than the
device actually has.

> Having said that, the only thing which limits this structure to be
> extended in future is the "line names block", simply because we don't
> know the size of it in advance and we need to keep it at the end for
> the same reason.

We have it's size, so the driver can calculate it (the likehood that
driver is done by some - even little - cpu is much higher than on the
device side). So, the next block would start right after that.

> A better approach for that, as Jean Philippe suggested earlier, is to
> rather add a new field, "gpio names offset", which will convey the
> offset of the names block from the beginning of the structure. In your
> case you can keep it to 0x40, while others can avoid the rather
> unnecessary padding.

Okay, but we'd still need the size field.

> What is CPU here? Driver/Guest ? I wonder if it would be better if we
> talk in terms of Virtio spec standards here, which are "device" and
> "driver".

Right, should be called "driver". Seems some of the terminology things
slipped through.

>> +\subsubsection{Message types}\label{sec:Device Types / General Purpose =
IO / Virtqueues / Message types}
>> +
>> +\begin{tabular}{|l|ll|}
>> +    \hline
>> +    \textbf{Code} & \textbf{Symbol} & \\
>> +    \hline
>> +    0x0001        & VIRTIO_GPIO_MSG_CPU_REQUEST            & request gp=
io line           \\
>=20
> This requires a corresponding "FREE" Msg type as well. This is already
> well implemented and accepted in Linux kernel as well.

Okay, lets add it.

>> +    0x0002        & VIRTIO_GPIO_MSG_CPU_DIRECTION_INPUT    & set direct=
ion to input      \\
>> +    0x0003        & VIRTIO_GPIO_MSG_CPU_DIRECTION_OUTPUT   & set direct=
ion to output     \\
>> +    0x0004        & VIRTIO_GPIO_MSG_CPU_GET_DIRECTION      & read curre=
nt direction      \\
>> +    0x0005        & VIRTIO_GPIO_MSG_CPU_GET_LEVEL          & read curre=
nt level          \\
>> +    0x0006        & VIRTIO_GPIO_MSG_CPU_SET_LEVEL          & set curren=
t (out) level     \\
>=20
> These look good.
>=20
>> +    0x0011        & VIRTIO_GPIO_MSG_DEVICE_LEVEL           & level chan=
ged (device->CPU) \\
>=20
> I believe this is the interrupt from Device to Driver ? I believe it
> would be more readable if it can be called as an interrupt.

Well, you could call it interrupt, sort of. Actually it's a level state
change notification - pure IRQ wouldn't necessarily carry the extra
data. For an HW engineer, an IRQ usually would be essentially one edge,
and one has to look very closely to find out what some particular edge
is actually meaning. IRQs usually just tell that *something* happened,
but you'll need extra steps (e.g. read out some registers) to find out
what actually did happen.

In this case, the DEVICE_LEVEL message is on a much higher level than a
plain IRQ, it also carries the information what exactly happened.

I'd say let the TC folks decide on the appropriate terminology.

> I do not see a way for masking/unmasking interrupts right now, we need
> them right now.=20

That's correct and intended. The problem is this needs extra logic on
the device for an interrupt controller, so I would hate to make it
mandatory for all. Not all gpio-controllers have such logic. On many
SoCs the gpio-controller has only *one* global IRQ line routed to some
IRQ controller somewhere else in the SOC. It depends on the actual setup
how we learn what actually happens. On Linux, when an gpio-consumer gets
a notification on some particular pin, a lot of (highly hw specific)
things already happened (eg. reading out several IRQ controllers to
follow the IRQ chain and finally reading the gpio line states from the
gpio-controller, possibly comparing w/ the last known state in order
to detect the edge direction, etc). Oh, and it even gets more complex:
some IRQ controllers automatically mask when IRQ is fired and need
explicit ack, some don't ... phuh.

Not trivial at all to find a good common ground for all scenarios as
well as minimal hardware requirements. That really needs some much
deeper thoughts to get it really right. Needs more discussions with
HW engineers.

You're certainly right that, at some point, we should have that. But it
really should be optional, so that actual silicon isn't required to have
its own IRQ controller.

> I am fine with adding other request types, like
> debounce, etc, later on, but interrupt support is bare minimum for us.

Do you have such a high load or extreme low-power requirements that you
cannot live without irq masking, until we have it as an optional feature
extension ? What HW are you using for the driver side ?

> These are the new request types we would need for that, unless there
> are more:
>=20
> IRQ_TYPE=09IRQ_MASK=09IRQ_UNMASK

With the mask it's getting interesting. Note we're (theoretically)
supporting 2^16 lines (real implementations probably stay much below
that), so we'd need enough room for that.

Maybe we should do it individually per line. This causes more traffic
at setup, but also has the positive side effect that driver can easily
mask/unmask invidual lines without remembering the mask.

> And these are the interrupt types we need to support, for now. Again
> they are quite standard if you look at Linux's GPIO support.
>=20
> IRQ_TYPE_NONE=09
> IRQ_TYPE_EDGE_RISING
> IRQ_TYPE_EDGE_FALLING=09
> IRQ_TYPE_EDGE_BOTH=09
> IRQ_TYPE_LEVEL_HIGH=09
> IRQ_TYPE_LEVEL_LOW

Well, "quite standard" is only when looking at what Linux gpio-subsys
supports. That doesn't mean that actual HW supports it directly. When
we make all these variants mandatory, we force a huge increase of the
hardware size (number of gates, chip size, power consumption).

We should be very careful in our decisions.

Note: I'm not doing this just for some host to vm signaling, but also
for actual hardware - embedded hardware. My goal also is laying out the
basis so this could become a standard interface even on-chip gpio-
controllers.

>> +    \hline
>> +    0x8000        & VIRTIO_GPIO_MSG_REPLY                  & device rep=
ly mask           \\
>> +    \hline
>> +\end{tabular}
>> +
>> +\devicenormative{\subsubsection}{Virtqueues}{Device Types / General Pur=
pose IO / Virtqueues}
>> +
>> +The device MUST read from the tx queue and write to rx queue.
>> +
>> +The device MUST NOT write to the tx queue.
>> +
>> +\drivernormative{\subsubsection}{Virtqueues}{Device Types / General Pur=
pose IO / Virtqueues}
>> +
>> +The device MUST read from the rx queue and write to tx queue.
>=20
> s/device/driver/ ?

You're right. Fixed that.

>> +
>> +\subsection{Data flow}\label{sec:Device Types / General Purpose IO / Da=
ta flow}
>> +
>> +\begin{itemize}
>> +    \item all operations, except \field{VIRTIO_GPIO_MSG_DEVICE_LEVEL}, =
are initiated by CPU (tx queue)
>> +    \item device replies with the orinal \field{type} value OR'ed with =
\field{VIRTIO_GPIO_MSG_REPLY} (rx queue)
>=20
> original*

fixed.

>> +    \item requests are processed and replied in the they had been sent
>=20
> in the *order* they...

fixed.

> Why is this important really ? If there are constraints in the control
> flow (i.e. operation 1 must happen before operation 2), then the
> request initiator needs to make sure of that.=20

The ordering is for associating request + reply. Otherwise we'd need
to add some kind of request identification (eq. seq numbers). I don't
see any good reason why some HW shouldn't keep the order inherently,
but it's probably better to leave no room for diferent interpretations
here.

> Otherwise, it doesn't
> matter which one finishes first. The response message will have the
> GPIO number in it and so the initiator will know whose response it is.

That's correct. At least for the currently defined operations, which
always have pin number. Who knows what the future will bring, so IMHO
it's better to care about that (even just hypothetical) issue now,
instead of running into trouble some time later.

Do you have any reason for NOT having this constraint.

> While on that, we must put a limit on number of messages started by
> one side for the same GPIO line. i.e. Driver can not start another
> operation for the same GPIO line, before receiving response for the
> previous request for that GPIO line. Same goes for interrupts from
> device to driver/CPU.

Queue size isn't enough for you ?

Or do you want an explicit per-line limit ? Why do you feel its needed ?
Is there anything that can go wrong with that ? Do you know any HW gpio
controller that has such a limit ?

Certainly, it might not be practically useful to fire too many changes
in a very short time, but could it cause any actual problem ?

>> +\end{itemize}
>> +
>> +
>> +\subsubsection{VIRTIO_GPIO_MSG_CPU_REQUEST}\label{sec:Device Types / Ge=
neral Purpose IO / Data flow / VIRTIO_GPIO_MSG_CPU_REQUEST}
>> +
>> +Notify the device that given line number is going to be used.
>> +
>> +\begin{tabular}{ll}
>> +    \hline
>> +    \textbf{request:} & \\
>> +    \hline
>> +    \field{line}  field: & logical line number \\
>=20
> s/logical/GPIO/ ?

if you insist, i'll change that ;-)

By the way: we've got a lot of repeated text here that calls for putting
it into macros. Since it's a big document - do we have any constraints
on the naming of such local macros ? I'm reluctant to doing dirty tricks
with undefining commands :o

>> +\begin{tabular}{ll}
>> +    \hline
>> +    \textbf{request:} & \\
>> +    \hline
>> +    \field{line}  field: & logical line number \\
>> +    \field{value} field: & line level (0=3Dinactive, 1=3Dactive) \\
>> +    \hline
>> +    \textbf{reply:} & \\
>> +    \hline
>> +    \field{value} field: & new line level or (negative) POSIX errno cod=
e \\
>=20
> Why not 0 for success? How will the driver use the returned value here ?

The idea was device doesn't need to touch this field if everything's
fine.

>> +\drivernormative{\subsubsection}{Data flow}{Device Types / General Purp=
ose IO / Data flow}
>> +
>> +The driver MUST NOT send VIRTIO_GPIO_MSG_DEVICE_LEVEL and MUST NOT set =
the highest bit in the message type.
>=20
> The device would need some kind of acknowledgement (as Linus also
> asked earlier) for the interrupt from the driver, before which it is
> eligible to send another interrupt for the same line.

No, this version does not have any kind of irq controller functionality.
It just sends this message unconditionally.

As already mentioned above, masking shall be an optional extra feature.

I'd suggest splitting the discussion into the basic functionality (that
we already have now) and additional features like IRQ controller etc.




--mtx

--=20
---
Hinweis: unverschl=C3=BCsselte E-Mails k=C3=B6nnen leicht abgeh=C3=B6rt und=
 manipuliert
werden ! F=C3=BCr eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schl=C3=BCssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

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

