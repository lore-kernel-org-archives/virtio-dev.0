Return-Path: virtio-comment-return-1333-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <159055235065.209072.12017445428967301686.stgit@ahduyck-workstation>
 <159055242270.209072.15091766786309829161.stgit@ahduyck-workstation>
From: David Hildenbrand <david@redhat.com>
Message-ID: <75b1a08b-c13d-89f2-a122-afd9c488677e@redhat.com>
Date: Wed, 24 Jun 2020 20:26:47 +0200
MIME-Version: 1.0
In-Reply-To: <159055242270.209072.15091766786309829161.stgit@ahduyck-workstation>
Content-Language: en-US
Subject: Re: [virtio-comment] [PATCH v4 3/3] content: Document balloon feature
 free page hints
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, mst@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 27.05.20 06:07, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>=20
> Free page hints allow the balloon driver to provide information on what
> pages are not currently in use so that we can avoid the cost of copying
> them in migration scenarios. Add a feature description for free page hint=
s
> describing basic functioning and requirements.
>=20
> In working on this the specification as pointed out certain issues with t=
he
> Linux driver and QEMU device implementation. The issues include:
> 1. The Linux driver does not re-initialize pages when it reuses them
> before receiving the "DONE" command, as such this can lead to possible da=
ta
> corruption.
> 2. The QEMU device is not returning the "DONE" command if a migration
> fails. This results in the guest holding onto pages until forced out by t=
he
> shrinker.
>=20
> There are also additional issues that have been found not related to the
> specification.
>=20
> There is currently discussion on if the feature should be removed so this
> patch is a place-holder for if we decide to keep the feature and fix the
> issues. Otherwise this patch can be dropped and we can work on a patch to
> document the need to avoid the feature.

Looks like the feature will stay, hope we can document the expected
semantics reasonably well now and fix the remaining issues. After all we
spend quite some time in reverse-engineering and fixing already ...

[...]
> =20
> +\subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloo=
n Device / Device Operation / Free Page Hinting}
> +
> +Free page hinting is designed to be used during migration to determine w=
hat
> +pages within the guest are currently unused so that they can be skipped =
over
> +while migrating the guest. The device will indicate that it is ready to =
start
> +performing hinting by setting the \field{free_page_hint_cmd_id} to one o=
f the
> +non-reserved values that can be used as a command ID. The following valu=
es
> +are reserved:

Maybe mention somewhere (resulting from a discussion with Michael) that
the semantics of hinted pages are similar to MADV_FREE, except
- it's asynchronous (and the cmd_id is used to synchronize)
- when reading pages after hinted, the content is undefined (might be
  something besides the old content or zero).

Might help to understand what the semantics are.

> +
> +\begin{description}
> +\item[VIRTIO_BALLOON_CMD_ID_STOP (0)] Any command ID previously supplied=
 by
> +  the device is invalid. The driver should stop hinting free pages until=
 a
> +  new command ID is supplied, but should not release any hinted pages fo=
r
> +  use by the guest.
> +
> +\item[VIRTIO_BALLOON_CMD_ID_DONE (1)] Any command ID previously supplied=
 by
> +  the device is invalid. The driver should stop hinting free pages, and
> +  should release all hinted pages for use by the guest.
> +\end{description}
> +
> +A request for free page hinting proceeds as follows:
> +
> +\begin{enumerate}
> +
> +\item The driver examines the \field{free_page_hint_cmd_id} configuratio=
n field.
> +  If it contains a non-reserved value then free page hinting will begin.
> +
> +\item To supply free page hints:
> +  \begin{enumerate}
> +  \item The driver constructs an output descriptor containing the new va=
lue
> +    from the \field{free_page_hint_cmd_id} configuration field and adds =
it to
> +    the free_page_hint_vq.
> +  \item The driver maps a series of pages and adds them to the
> +    free_page_hint_vq as individual scatter-gather input descriptor entr=
ies.
> +  \item When the driver is no longer able to fetch additional pages to a=
dd
> +    to the free_page_hint_vq, it will construct an output descriptor
> +    containing the command ID VIRTIO_BALLOON_CMD_ID_STOP.
> +  \end{enumerate}
> +
> +\item A round of hinting ends either when the driver is no longer able t=
o
> +  supply more pages for hinting as described above, or when the device
> +  updates \field{free_page_hint_cmd_id} configuration field to contain e=
ither
> +  VIRTIO_BALLOON_CMD_ID_STOP or VIRTIO_BALLOON_CMD_ID_DONE.
> +
> +\item The device may follow VIRTIO_BALLOON_CMD_ID_STOP with a new
> +  non-reserved value for the \field{free_page_hint_cmd_id} configuration
> +  field in which case it will resume supplying free page hints.
> +
> +\item Otherwise, if the device provides VIRTIO_BALLOON_CMD_ID_DONE then
> +  hinting is complete and the driver may release all previously hinted
> +  pages for use by the guest.
> +
> +\end{enumerate}
> +
> +\drivernormative{\paragraph}{Free Page Hinting}{Device Types / Memory Ba=
lloon Device / Device Operation / Free Page Hinting}
> +
> +Normative statements in this section apply if the
> +VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.
> +
> +The driver SHOULD supply pages to the free page hints when
> +\field{free_page_hint_cmd_id} reports a value of 2 or greater.
> +

nit: I'd avoid using the term "report" here. Maybe "specifies" or sth.
like that.

> +The driver MUST start hinting by providing an output descriptor
> +containing the current command ID for the given block of pages.
> +
> +The driver SHOULD stop supplying pages for hinting when
> +\field{free_page_hint_cmd_id} reports a value of VIRTIO_BALLOON_CMD_ID_S=
TOP.

"or VIRTIO_BALLOON_CMD_ID_DONE" I assume.

> +
> +If the driver is unable to supply pages, it MUST complete hinting by add=
ing
> +an output descriptor containing the command ID VIRTIO_BALLOON_CMD_ID_STO=
P.
> +
> +The driver MAY release hinted pages for use by the guest including when =
the
> +device has not yet used the descriptor containing the hinting request.
> +
> +The driver MUST treat the content of all hinted pages as uninitialized
> +memory.
> +
> +The driver MUST initialize the contents of any previously hinted page
> +released before \field{free_page_hint_cmd_id} reports a value of
> +VIRTIO_BALLOON_CMD_ID_DONE.

Ack.

> +
> +The driver SHOULD release all previously hinted pages for use by the gue=
st
> +once \field{free_page_hint_cmd_id} reports a value of
> +VIRTIO_BALLOON_CMD_ID_DONE.
> +
> +\devicenormative{\paragraph}{Free Page Hinting}{Device Types / Memory Ba=
lloon Device / Device Operation / Free Page Hinting}
> +
> +Normative statements in this section apply if the
> +VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.
> +
> +The device MUST set \field{free_page_hint_cmd_id} to
> +VIRTIO_BALLOON_CMD_ID_STOP any time that the dirty pages for the given
> +guest are being recorded.

Hm. The "dirty pages" wording  is a little bit too (migration) specific
for my taste. Will think about this more.

> +
> +The device MUST NOT reuse a command ID until it has received an output
> +descriptor containing VIRTIO_BALLOON_CMD_ID_STOP from the driver.
> +
> +The device MUST ignore pages that are provided with a command ID that do=
es
> +not match the current value in \field{free_page_hint_cmd_id}.

ACK, that's what you fixed.

> +
> +If the content of a previously hinted page has not been modified by the
> +guest since the device issued the \field{free_page_hint_cmd_id} associat=
ed
> +with the hint, the device MAY modify the contents of the page.

Only before setting DONE, correct? But ...

> +
> +The device MUST NOT modify the content of a previously hinted page after
> +\field{free_page_hint_cmd_id} is set to VIRTIO_BALLOON_CMD_ID_DONE.

... there it is :)

> +
> +The device MUST report a value of VIRTIO_BALLOON_CMD_ID_DONE in
> +\field{free_page_hint_cmd_id} when it no longer has need for the
> +previously hinted pages.

Right, that's still to be fixed if migration fails. I think we can reuse
the CLEANUP part.


Will we have to document that the guest must only indicate a cmd_id (in
out_buf) only once and not multiple times? Essentially what we discussed
in reply to your latest fix.

Again, thanks a lot for documenting and fixing ...

--=20
Thanks,

David / dhildenb


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

