Return-Path: virtio-comment-return-1904-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Thu, 17 Jun 2021 11:41:21 +0200
Message-Id: <20210617094122.1627-1-info@metux.net>
MIME-Version: 1.0
Subject: [virtio-comment] Repost due mailist failure: virtio-gpio: add formal specification
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hello folks,


this is repost of the patch to formally introduce specification of the alre=
ady
implemented and announced virtio-gpio from late 2020. Multiple attempts of
posting this patch over the last week didn't go through the list server due=
 to
(yet not fully understood) technical problems. Tried resubscribing to both =
lists,
if you receive that mail, the problems is probably solved (at least for me =
:))

This patch introduces a now tex'ified version of the spec already submitted
in late 2020. Back then the official specification process was blocked by y=
et
missing formal / editorial steps, namely ID allocation and tex'ifying the
ascii text into the official specification document. Unfortunately, I had t=
o put
it aside for a while due to more pressing tasks (keeping public infrastruct=
ure
up and running while in the middle of lockdown).

The current specification is semantically equal (fully compatible) to the A=
SCII
text version from late 2020, it only received terminology changes (e.g. rep=
lacing
"host" and "guest" by "driver" and "device") some clarifications.

In the mean time, the existing implementations for both device and driver s=
ide
are running in the field, in embedded and industrial applications, indicati=
ng that
general semantics should be fine. Maybe just some minor ambiguities in the =
spec
text yet to be ironed out.

Note:

Maybe the protocol might look a bit strange for someone who's just looking =
from the
VM perspective. The design decisions also have simplicistic hardware implem=
entations
in mind, e.g. reuse message buffers for rx and tx (no need for actual memor=
y management),
pretty direct wireup between IO drivers and buffer latches and hardwired de=
coding
(no actual sram required), and most importantly: more sophisticated feature=
s (e.g.
features often implemented in pinmuxes, like stength control, trigger thres=
holds,
inverters, debounce filters, etc) have intentionally left out at this point=
 and will
be added as purely optional features in the future. The idea behind that de=
cision is
to allow very minimal implementations of the gpio itself, and leave enough =
time for
careful consideration where those extra units actually be placed (e.g. shal=
l virtio-gpio
have pinmux features at all ? several pro's and con's have to be weighted y=
et).

I've received positive feedback HW/VHDL engieers, stating that first hw imp=
lementation
was pretty straigthforward - for ASICS they're planning more optimizations =
in order
to reduce the number of gates by a magnitude. (Since I'm not an HW/VHDL exp=
ert, so I
can't comment much on this)

Finally I'm feeling very confident that virtio-gpio might show good case fo=
r using
virtio even in lo-profile / lo-power hardware and good change of replacing =
proprietary
interchip/intrachip protocols.


best regards,
--mtx


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

