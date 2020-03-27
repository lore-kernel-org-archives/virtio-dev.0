Return-Path: virtio-comment-return-1167-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Mar 2020 10:38:00 +0000
Message-Id: <20200327103803.10460-6-alex.bennee@linaro.org>
In-Reply-To: <20200327103803.10460-1-alex.bennee@linaro.org>
References: <20200327103803.10460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] [RFC PATCH  5/8] Cleanup old changelog files
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

These are no longer included in the document although their contents
will be forever available in the repositories history.

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 cl-cs01.tex    |   86 ----
 cl-cs02.tex    |   52 ---
 cl-cs03.tex    |  328 ---------------
 cl-cs04.tex    |  134 -------
 cl-csprd02.tex | 1043 ------------------------------------------------
 cl-csprd03.tex |  400 -------------------
 6 files changed, 2043 deletions(-)
 delete mode 100644 cl-cs01.tex
 delete mode 100644 cl-cs02.tex
 delete mode 100644 cl-cs03.tex
 delete mode 100644 cl-cs04.tex
 delete mode 100644 cl-csprd02.tex
 delete mode 100644 cl-csprd03.tex

diff --git a/cl-cs01.tex b/cl-cs01.tex
deleted file mode 100644
index 234e420..0000000
--- a/cl-cs01.tex
+++ /dev/null
@@ -1,86 +0,0 @@
-418 & 11 Aug 2014 & Michael S. Tsirkin & { Acknowledge input from
-Brian Foley
-
-See \ref{chap:Acknowledgements}
-}
- \\
-417 & 11 Aug 2014 & Pawel Moll & {  VIRTIO-110: ARM's feedback for MMIO ch=
apter, clarifications
-
-\begin{itemize}
-    \item Extra clarifications for QueueReady and ConfigGeneration
-    \item Added alignment requirement section, to formalise
-      hidden assumptions about register accesses
-\end{itemize}
-
-See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO
-Device Register Layout}, \ref{devicenormative:Virtio Transport
-Options / Virtio Over MMIO / MMIO Device Register Layout} and
-\ref{drivernormative:Virtio Transport
-Options / Virtio Over MMIO / MMIO Device Register Layout}
-}
- \\
-\hline
-\hline
-416 & 05 Aug 2014 & Pawel Moll & { VIRTIO-110: ARM's feedback for MMIO cha=
pter, legacy section
-
-Make it clear that the legacy section is non-normative,
-removing all MUSTs.
-
-See \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy
-interface}.
- } \\
-\hline
-415 & 05 Aug 2014 & Pawel Moll & { VIRTIO-110: ARM's feedback for MMIO cha=
pter, trivial changes
-\begin{itemize}
-\item Typos and language mistakes in 4.2, 4.2.1, 4.2.2 and 4.2.2.2.
-\item Extra clarifications for InterruptACK.
-\end{itemize}
- } \\
-\hline
-414 & 04 Aug 2014 & Michael S. Tsirkin & { legacy: grammar fixup
-
-Legacy devices are "they" not "it".
-
-See \ref{sec:General Initialization And Device Operation / Device
-Initialization / Legacy Interface: Device Initialization}
-
-Resolves VIRTIO-113
- } \\
-\hline
-413 & 04 Aug 2014 & Michael S. Tsirkin & { legacy: consistently use past t=
ense
-
-Paragraph with general description of feature negotiation
-for legacy devices mixed present and past tense.
-As rest of legacy sections all use past tense,
-fix the only instance of the present tense:
-s/do/did/ for consistency.
-
-It might be argued that legacy devices still have these
-properties so present tense is more appropriate, on the
-other hand, using the past tense helps stress the fact
-that current spec does not attempt to fully describe the legacy
-device/driver behaviour: this text is only here to serve as
-motivation for the transitional device/driver requirements.
-
-See \ref{sec:General Initialization And Device Operation / Device
-Initialization / Legacy Interface: Device Initialization}
-
-Resolves VIRTIO-112
- } \\
-\hline
-412 & 30 Jul 2014 & Michael S. Tsirkin & { VIRTIO-111: Fix minor typos
-
-Fix minor typos as reported in ARM's feedback.
-
-See \ref{drivernormative:Basic Facilities of a Virtio Device /
-Device Configuration Space}, \ref{sec:Basic Facilities of a
-Virtio Device / Device Configuration Space / Legacy Interface:
-Device Configuration Space}, \ref{sec:General Initialization And
-Device Operation / Device Operation / Supplying Buffers to The
-Device} and
-\ref{drivernormative:Device Types / Network Device / Device
-Operation / Control Virtqueue / Offloads State Configuration /
-Setting Offloads State}
- }
- \\
-\hline
diff --git a/cl-cs02.tex b/cl-cs02.tex
deleted file mode 100644
index 61aa6fd..0000000
--- a/cl-cs02.tex
+++ /dev/null
@@ -1,52 +0,0 @@
-448 & 22 Dec 2014 & Michael S. Tsirkin & {VIRTIO-120: virtio:
-fix used element size
-
-General ring description lists size for
-used ring elements as 4, it must be 8.
-
-See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues}.
- } \\
-\hline
-449 & 22 Doc 2014 & Cornelia Huck & {VIRTIO-125: block: fixup section leve=
ls
-    The specification for the configuration layout for block devices
-    should be its own subsection as for all other devices and not be
-    hidden beneath "Feature bits".
-   =20
-    The normative sections for device operation should appear under
-    the device operation section.
-See \ref{sec:Device Types / Block Device / Device configuration
-layout}.
- } \\
-\hline
-450 & 22 Dec 2014 & Cornelia Huck & {VIRTIO-127: ccw: two-stage
-indicators for legacy devices
-
-    Some legacy devices will support two-stage queue indicators
-and therefore
-    won't reject CCW_CMD_SET_IND_ADAPTER. Note this.
-
-See \ref{sec:Virtio Transport Options / Virtio over channel I/O /
-Device Initialization / Setting Up Indicators / Legacy
-Interfaces: A Note on Setting Up Indicators}.
- } \\
-\hline
-452 & 22 Dec 2014 & Michael S. Tsirkin & {VIRTIO-115:
-formatting: escape {\textbackslash}ldots in lstlisting
-
-    {\textbackslash}ldots does not work within lstlisting, the result is
-    {\textbackslash}ldots verbatim in the PDF output.
-
-    To fix, make \$ an escape character, and escape the sequence:
-    \${\textbackslash}ldots\$
-
-See \ref{sec:Device Types / SCSI Host Device / Device Operation /
-Device Operation: controlq}.
-} \\
-\hline
-455,457 & 23 Dec 2014 & Michael S. Tsirkin & {acknowledgements: acknowledg=
e dgilbert
-   =20
-    Acknowledge David Alan Gilbert for reporting VIRTIO-120.
-
-See \ref{chap:Acknowledgements}.
-} \\
-\hline
diff --git a/cl-cs03.tex b/cl-cs03.tex
deleted file mode 100644
index 72925ca..0000000
--- a/cl-cs03.tex
+++ /dev/null
@@ -1,328 +0,0 @@
-478 & 15 Mar 2015 & Cornelia Huck & {VIRTIO-129: legacy:
-clean up virtqueue layout definitions
-
-Generalize "Legacy Interfaces: A Note on Virtqueue Layout" to allow
-for different alignment requirements. Have pci and ccw refer to that
-section for legacy devices. Remove the double definition of virtqueue
-alignment (which referred to legacy, but was not tagged as such) from
-the ccw section.
-See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues /
-Legacy Interfaces: A Note on Virtqueue Layout}, \ref{sec:Virtio
-Transport Options / Virtio Over PCI Bus / PCI-specific
-Initialization And Device Operation / Device Initialization /
-Virtqueue Configuration / Legacy Interface: A Note on Virtqueue
-Configuration} and \ref{sec:Virtio Transport Options / Virtio
-over channel I/O / Device Initialization / Configuring a
-Virtqueue / Legacy Interface: A Note on Configuring a Virtqueue}.
- } \\
-\hline
-479 & 15 Mar 2015 & Cornelia Huck & {VIRTIO-118:
-ccw: clarify basic channel commands
-
-"Basic channel commands" seems to be not as clear as it
-could, so let's spell out which channel commands we refer to.
-See \ref{sec:Virtio Transport Options / Virtio over channel I/O /
-Basic Concepts}.
-} \\
-\hline
-479 & 15 Mar 2015 & Cornelia Huck & {VIRTIO-116:
-ccw: allow WRITE_STATUS to fail
-   =20
-We want to be able to fail setting a status on the device
-(e.g.  FEATURES_OK if the device can't work with the features
-negotiated).
-The easiest way to do that is to allow the device to fail the
-WRITE_STATUS command by posting a command reject.
-See \ref{sec:Virtio Transport Options / Virtio over channel I/O /
-Device Initialization / Communicating Status Information}.
- } \\
-\hline
-485 & 15 Mar 2015 & Jason Wang & {VIRTIO-135:
-virtio-ring: comment fixup
-   =20
-virtio_ring.h included with spec has this text:
-/* Support for avail_idx and used_idx fields */
-it should really refer to avail_event and used_event.
-See Appendix \ref{sec:virtio-queue.h}.
- } \\
-\hline
-486 & 15 Mar 2015 & Jason Wang & {VIRTIO-136:
-document idx field in virtqueue used ring
-
-Section \ref{sec:Basic Facilities of a Virtio Device / Virtqueues
-/ The Virtqueue Used Ring} The Virtqueue Used Ring
-listed the idx field, but never documented it.
-See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues /
-The Virtqueue Used Ring}.
- } \\
-\hline
-487 & 15 Mar 2015 & Rusty Russell & {VIRTIO-130:
-ISR status: Fix incorrect diagram
-
-ISR status capability diagram has the "Device Configuration
-Interrupt " as bit 0, and the "Queue Interrupt" as bit 1. This is
-the wrong way around: it disagrees with the legacy
-implementations, as well as the spec elsewhere.
-
-All current guests correctly follow the text, fix
-up the diagram to match.
-See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI
-Device Layout / ISR status capability}.
- } \\
-\hline
-488 & 15 Mar 2015 & Rusty Russell & {VIRTIO-133:
-Change 4.1.5.1.2.1 to device requirement
-
-4.1.5.1.2.1 is incorrectly labelled as a driver requirement; it's
-self-evidently referring to the device.
-See \ref{sec:Conformance / Driver Conformance / PCI Driver
-Conformance}, \ref{sec:Conformance / Device Conformance / PCI
-Device Conformance} and \ref{devicenormative:Virtio
-Transport Options / Virtio Over PCI Bus / PCI-specific
-Initialization And Device Operation / Device Initialization /
-Non-transitional Device With Legacy Driver}.
- } \\
-\hline
-504 & 22 Apr 2015 & Rusty Russell & {VIRTIO-137:
-define the meaning and requirements of the len field.
-   =20
-We said what it was for, and noted why.  We didn't place any
-requirements on it, nor clearly spell out the implications of its use.
-   =20
-This clarification comes particularly from noticing that QEMU
-didn't set len correctly, and philosophising over the correct value
-when an error has occurred.
-See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues /
-The Virtqueue Used Ring}, \ref{devicenormative:Basic Facilities
-of a Virtio Device / Virtqueues / The Virtqueue Used Ring} and
-\ref{sec:Basic Facilities of a Virtio Device / Virtqueues / The
-Virtqueue Used Ring}.
- } \\
-\hline
-506 & 22 Apr 2015 & Michael S. Tsirkin & {VIRTIO-138:
-multiple errors: Non-transitional With Legacy
-
-virtio 1.0 has two sections titled "Non-transitional Device With
-Legacy Driver" the first says devices SHOULD fail, the second
-says devices MUST fail.  Clearly a mistake.
-
-Other issues: devices don't really fail - they cause drivers to
-fail. second section seems to be in the wrong place, and also
-have a section followed by subsection with no explanatory text in
-between, which is ugly.
-Finally, this text was originally ritten to handle buggy windows
-drivers gracefully, but later we changed device IDs so it's not
-really required there. Might be handy for some other buggy legacy
-drivers, though no such drivers are known.
-
-To fix, drop the duplicate section variant, add some explanatory
-text, clarify what does "same ID" mean here, and clarify
-that the work-around is only needed if a buggy driver
-is known to bind to a transitional device.
-
-See \ref{sec:Virtio Transport Options / Virtio
-Over PCI Bus / PCI Device Layout / Non-transitional Device With
-Legacy Driver: A Note on PCI Device Layout},
-\ref{devicenormative:Virtio Transport Options / Virtio Over PCI
-Bus / PCI-specific Initialization And Device Operation / Device
-Initialization / Non-transitional Device With Legacy Driver} and
-\ref{sec:Virtio Transport Options / Virtio Over PCI Bus /
-PCI-specific Initialization And Device Operation / Device
-Initialization}.
-} \\
-\hline
-508 & 22 Apr 2015 & Michael S. Tsirkin & {VIRTIO-139:
-pci: missing documentation for dealing with 64 bit config fields
-   =20
-pci spec says what width access to use for 32, 16 and 8
-bit fields, but does not explicitly say what to do for
-32 bit fields. As we have text that says driver must
-treat 64 bit accesses as non-atomic, this seems
-to imply driver should always do two 32 bit wide accesses.
-
-Let's make this an explicit requirement, and require
-devices to support this.
-
-See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI
-Device Layout}, \ref{drivernormative:Virtio Transport Options /
-Virtio Over PCI Bus / PCI Device Layout},
-\ref{devicenormative:Virtio Transport Options / Virtio Over PCI
-Bus / PCI Device Layout} and \ref{sec:Conformance / Driver
-Conformance / PCI Driver Conformance}.
- } \\
-\hline
-509 & 22 Apr 2015 & Michael S. Tsirkin & {balloon:
-MUST -> has to
-
-MUST shouldn't be used outside normative statements,
-that's confusing. Replace with "has to".
-
-See \ref{sec:Device Types / Memory Balloon Device / Feature
-bits}.
- } \\
-\hline
-510 & 22 Apr 2015 & Michael S. Tsirkin & {conformance:
-add VIRTIO-137 statement links
-
-Add links to new conformance statements added to
-resolve VIRTIO-137 (describing used ring entry len usage).
-
-See \ref{sec:Conformance / Device Conformance}
-and \ref{sec:Conformance / Driver Conformance}.
- } \\
-\hline
-517 & 22 Apr 2015 & Michael S. Tsirkin & {acknowledgements:
-contributors+minor fixup
-
-acknowledge feedback by Jason Wang, add Richard Sohn who
-joined the TC, sort acknowledged reviewers alphabetically.
-
-See \ref{chap:Acknowledgements}.
-} \\
-\hline
-520 & 30 Apr 2015 & James Bottomley & {VIRTIO-140:
-give explicit guidance on the use of 64 bit fields
-
-Just saying 64 bit fields may not be atomic is true, but less
-helpful than it might be.  Add explicit guidance about what the
-consequences of non-atomicity are.
-
-See \ref{sec:Creating New Device Types / What Device
-Configuration Space Layout?}
-} \\
-\hline
-521 & 30 Apr 2015 & Rusty Russell & {VIRTIO-134:
-Spell out details of indirect elements in chains
-   =20
-1) It's implied that a chain terminates with an indirect descriptor (since
-VIRTIO-15) but we didn't spell out that a device MUST NOT
-continue it.
-   =20
-2) We allow [direct]->[direct]->[indirect], and qemu and
-bhyve both accept it.  Make it clear that this is valid, thus devices MUST
-handle it.
-
-See \ref{drivernormative:Basic Facilities of a Virtio Device /
-Virtqueues / The Virtqueue Descriptor Table / Indirect
-Descriptors} and \ref{devicenormative:Basic Facilities of a
-Virtio Device / Virtqueues / The Virtqueue Descriptor Table /
-Indirect Descriptors}
-} \\
-\hline
-522 & 30 Apr 2015 & Michael S. Tsirkin & {VIRTIO-141:
-used ring: specify legacy behaviour for len field
-
-many hypervisors implemented len field incorrectly.
-Document existing bugs in the legacy sections.
-
-See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues
-/ The Virtqueue Used Ring/ Legacy Interface: The Virtqueue Used
-Ring}, \ref{sec:Device Types / Network Device / Device Operation
-/ Legacy Interface: Device Operation}, \ref{sec:Device Types /
-Block Device / Device Operation / Legacy Interface: Device
-Operation}, \ref{sec:Device Types / Console Device / Device
-Operation / Legacy Interface: Device Operation}, \ref{sec:Device
-Types / Memory Balloon Device / Device Operation / Legacy
-Interface: Device Operation}, \ref{sec:Device
-Types / SCSI Host Device / Device Operation / Legacy
-Interface: Device Operation} and \ref{sec:Conformance / Legacy
-Interface: Transitional Device and Transitional Driver
-Conformance}.
-} \\
-\hline
-523 & 30 Apr 2015 & Michael S. Tsirkin & {VIRTIO-142:
-entropy device: typo fix
-
-Current text: "The driver MUST examine the length written by the
-driver" makes no sense. length is written by the device.
-
-See \ref{drivernormative:Device Types / Entropy Device / Device
-Operation}.
-} \\
-\hline
-526 & 18 May 2015 & Michael S. Tsirkin & {VIRTIO-143:
-balloon: transitional device support
-
-Support a transitional balloon device: this has the advantage of supportin=
g
-existing drivers, transparently, as well as transports that don't allow mi=
xing
-virtio 0 and virtio 1 devices. And balloon is an easy device to test, so i=
t's
-also useful for people to test virtio core handling of transitional device=
s.
-
-Three issues with legacy hypervisors have been identified:
-\begin{enumerate}
-\item
-Actual value is actually used, and is necessary for management
-to work. Luckily 4 byte config space writes are now atomic.
-When using old guests, hypervisors can detect access to the last byte.
-When using old hypervisors, drivers can use atomic 4-byte accesses.
-\item Hypervisors actually didn't ignore the stats from the first
-buffer supplied. This means the values there would be
-incorrect until hypervisor resends the request.
-Add a note suggesting hypervisors ignore the 1st buffer.
-\item QEMU simply over-writes stats from each buffer it gets.
-Thus if driver supplies a different subset of stats
-on each request, stale values will be there.
-Require drivers to supply the same subset on each
-request. This also gives us a simple way to figure out
-which stats are supported.
-\end{enumerate}
-
-See
-\ref{sec:Device Types / Memory Balloon Device},
-\ref{devicenormative:Virtio Transport Options / Virtio Over PCI Bus / PCI =
Device Discovery},
-\ref{sec:Conformance / Driver Conformance / Traditional Memory Balloon Dri=
ver Conformance},
-\ref{sec:Conformance / Device Conformance / Traditional Memory Balloon Dev=
ice Conformance},
-\ref{sec:Conformance / Legacy Interface: Transitional Device and Transitio=
nal Driver Conformance},
-\ref{sec:Conformance / Device Conformance} and \ref{sec:Conformance / Driv=
er Conformance}.
-} \\
-\hline
-527 & 18 May 2015 & Michael S. Tsirkin & {VIRTIO-126:
-document deflate on oom
-
-Document the new option, and also clarify behaviour
-without it.
-
-In particular, actual field is not the
-actual number of pages in the balloon as
-driver might do inflate followed by deflate.
-
-Also, device isn't always driven by interrupts,
-driver can inflate/deflate in response to e.g.
-memory compaction.
-
-See \ref{sec:Device Types / Memory Balloon Device / Feature bits},
-\ref{sec:Device Types / Memory Balloon Device / Device Operation} and
-\ref{drivernormative:Device Types / Memory Balloon Device / Device Operati=
on}.
-} \\
-\hline
-528 & 18 May 2015 & Michael S. Tsirkin & {VIRTIO-123:
-network device: xmit/receive cleanup
-
-Fix up multiple issues in xmit/receive sections:
-\begin{itemize}
-   \item drop MAY/MUST/SHOULD outside normative statements
-   \item spell out conformance requirements for both drivers and
-      devices, for xmit and receive paths
-   \item document the missing VIRTIO_NET_HDR_F_DATA_VALID
-   \item document handling of unrecognized flag bits so we can extend
-      flags in the future, similar to VIRTIO_NET_HDR_F_DATA_VALID
-\end{itemize}
-
-\ref{sec:Device Types / Network Device / Device Initialization},
-\ref{drivernormative:Device Types / Network Device / Device Operation / Pa=
cket Transmission},
-\ref{devicenormative:Device Types / Network Device / Device Operation / Pa=
cket Transmission},
-\ref{sec:Device Types / Network Device / Device Operation / Processing of =
Incoming Packets},
-\ref{sec:Conformance / Driver Conformance / Network Driver Conformance} an=
d
-\ref{sec:Conformance / Device Conformance / Network Device Conformance}.
-} \\
-\hline
-529 & 18 May 2015 & Michael S. Tsirkin & {VIRTIO-124:
-network device: document VIRTIO_NET_F_CTRL_RX_EXTRA
-
-See
-\ref{sec:Device Types / Network Device / Device Operation / Control Virtqu=
eue / Packet Receive Filtering},
-\ref{sec:Device Types / Network Device / Device Operation / Control Virtqu=
eue / Setting MAC Address Filtering},
-\ref{sec:Conformance / Driver Conformance / Network Driver Conformance} an=
d
-\ref{sec:Conformance / Device Conformance / Network Device Conformance}.
-} \\
-\hline
diff --git a/cl-cs04.tex b/cl-cs04.tex
deleted file mode 100644
index fc12cdd..0000000
--- a/cl-cs04.tex
+++ /dev/null
@@ -1,134 +0,0 @@
-540 & 11 Oct 2015 & Greg Kurz & {virtqueues: fix
-trivial typo
-
-See
-\ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer No=
tification Suppression}.
-} \\
-\hline
-541 & 11 Oct 2015 & Paolo Bonzini & {virtio-blk: fix typo
-in legacy framing requirements section
-
-See
-\ref{sec:Device Types / Block Device / Legacy Interface: Framing Requireme=
nts}.
-} \\
-\hline
-545 & 18 Oct 2015 & Paolo Bonzini & {virtio-blk: restore VIRTIO_BLK_F_FLUS=
H and VIRTIO_BLK_F_CONFIG_WCE
-
-VIRTIO_BLK_F_CONFIG_WCE is important in order to achieve good performance
-(up to 2x, though more realistically +30-40\%) in latency-bound workloads.
-However, it was removed by mistake together with VIRTIO_BLK_F_FLUSH.
-
-In addition, even removing VIRTIO_BLK_F_FLUSH was probably not a great
-idea, because it simplifies simple drivers (e.g. firmware) that are okay
-with a writethrough cache but still need data to persist after power loss.
-What really should have been removed is just the possibility that devices
-not propose VIRTIO_BLK_F_FLUSH, but even that only deserves a "SHOULD" in
-the new world of conformance statements.
-
-Restore these, with the following changes:
-
-* clarify and use conformance statements in order to define writeback
-and writethrough caching according to what is commonly done by high-end
-storage.
-
-* clarify (with conformance statements) the influence of the
-VIRTIO_BLK_F_FLUSH feature on caching and how to proceed if only one of
-VIRTIO_BLK_F_FLUSH and VIRTIO_BLK_F_CONFIG_WCE is negotiated.
-
-* strengthen the requirement for persisting writes to MUST after
-a VIRTIO_BLK_T_FLUSH request (and in other cases too involving the
-new features).
-
-The suggested behavior upon feature negotiation is okay for the Linux
-implementation of virtio1, even after the implementation is modified to
-support the two new features.
-
-This fixes VIRTIO-144.
-
-See \ref{sec:Device Types / Block Device},
-\ref{sec:Conformance / Driver Conformance / Block Driver Conformance} and
-\ref{sec:Conformance / Device Conformance / Block Device Conformance}.
-} \\
-\hline
-546 & 18 Oct 2015 & Michael S. Tsirkin & {pci: clarify configuration acces=
s capability rules
-
-The point of the configuration access capability is to enable
-access to other capabilities.  The intent never was to allow
-writes to a random place within device BARs.
-Limiting drivers simplifies devices - and devices can always
-add another capability if drivers ever want to access
-some other range.
-
-This resolves VIRTIO-145.
-
-See \ref{drivernormative:Virtio Transport Options / Virtio Over
-PCI Bus / PCI Device Layout / PCI configuration access
-capability}.
-} \\
-\hline
-547 & 18 Oct 2015 & Michael S. Tsirkin & {add advice on transition from le=
gacy interfaces
-
-Reading legacy chapters gives a hint about what changed,
-let's help readers discover this useful shortcut.
-
-This resolves VIRTIO-146.
-
-See \ref{sec:Transition from earlier specification drafts}.
-} \\
-\hline
-554 & 16 Feb 2016 & Thomas Huth & {virtio-net: fix inconsistent legacy hea=
der size
-
-    Current text says:
-    =09The legacy driver only presented num_buffers in the struct
-    =09virtio_net_hdr when VIRTIO_NET_F_MRG_RXBUF was not negotiated;
-
-    Should be:
-    =09"\dots was negotiated \dots" instead of "\dots was not negotiated \=
dots"
-
-    To be consistent with the following:
-    =09without that feature the structure was 2 bytes shorter.
-
-See \ref{sec:Device Types / Network Device / Device Operation / Legacy Int=
erface: Device Operation}.
-} \\
-\hline
-555 & 16 Feb 2016 & Michael S. Tsirkin & {virtio header: tweak
-change motivation
-
-    The changes are not just to remove Linux assumptions,
-    we have also renamed ring->queue.
-    Tweak the header description accordingly.
-
-See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Helpers fo=
r Operating Virtqueues}.
-} \\
-\hline
-558 & 16 Feb 2016 & Michael S. Tsirkin & {rename virtio_ring.h to virtio_q=
ueue.h
-
-    Since vring* and VRING* have been replaced with virtq* and VIRTQ*
-    respectively, rename the header virtio_ring.h to virtio_queue.h.
-
-See \ref{sec:virtio-queue.h}.
-} \\
-\hline
-559 & 16 Feb 2016 & Michael S. Tsirkin & {init: sort status bits
-
-    Status bit order is inconsistent: they are neither in increasing
-    order nor in the order they are likely to be used.
-
-    The second approach seems more useful since there aren't
-    that many bits, so the numerical order does not help much.
-
-    A typical order of use would be:
-
-\begin{itemize}  =20
-\item    ACKNOWLEDGE
-\item    DRIVER
-\item    then either FAILED or FEATURES_OK
-\item    then either FAILED or DRIVER_OK
-\item    then DEVICE_NEEDS_RESET (if device detects an error)
-\end{itemize}
-   =20
-    Sort the bits accordingly.
-
-See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}.
-} \\
-\hline
diff --git a/cl-csprd02.tex b/cl-csprd02.tex
deleted file mode 100644
index 1e0f53d..0000000
--- a/cl-csprd02.tex
+++ /dev/null
@@ -1,1043 +0,0 @@
-316 & 05 Mar 2014 & Michael S. Tsirkin & { legacy framing: scsi host
- } \\
-\hline
-315 & 05 Mar 2014 & Michael S. Tsirkin & { legacy message framing: console=
 device
- } \\
-\hline
-314 & 05 Mar 2014 & Michael S. Tsirkin & { block: legacy message framing
- } \\
-\hline
-313 & 05 Mar 2014 & Michael S. Tsirkin & { message framing: rusty's commen=
ts
-
-generic note on message framing
-
-specific requirements listed for net device only
- } \\
-\hline
-312 & 05 Mar 2014 & Michael S. Tsirkin & { legacy devices: get rid of MUST=
 assume
-
-as Rusty points out MUST assume is not very good requirement.
-
-clarify it.
- } \\
-\hline
-311 & 05 Mar 2014 & Michael S. Tsirkin & { transitional driver features: f=
ix typos noted by Rusty
- } \\
-\hline
-310 & 03 Mar 2014 & Rusty Russell & { Formatting: use latex-style quoting =
everywhere.
-
-Doesn't look any different, but consistent.
- } \\
-\hline
-309 & 03 Mar 2014 & Rusty Russell & { Use ellipsis (aka \textbackslash ldo=
ts) everywhere.
-
-And use the ellipsis package, which makes it symmetrical.
- } \\
-\hline
-308 & 03 Mar 2014 & Rusty Russell & { PCI: Tighten requirements.
-
-1) make it clear that queue_enable is 0 on reset.
-
-2) device MUST present a  VIRTIO_PCI_CAP_DEVICE_CFG if needed for type.
- } \\
-\hline
-307 & 02 Mar 2014 & Michael S. Tsirkin & { initialization: minor clarifica=
tion
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
-
-"it" could refer to failed bit or the driver.
-
-clarify.
- } \\
-\hline
-306 & 02 Mar 2014 & Michael S. Tsirkin & { fix rfc2119 reference
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
-
-VIRTIO-68
-
-Cc: Patrick Durusau <patrick@durusau.net>
- } \\
-\hline
-305 & 02 Mar 2014 & Michael S. Tsirkin & { VIRTIO-67: fix html redirects
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
-
-1. oasis switched to https
-
-2. Red Hat  is www.redhat.com
-
-Cc: Patrick Durusau <patrick@durusau.net>
- } \\
-\hline
-304 & 02 Mar 2014 & Michael S. Tsirkin & { feedback: clarify device status=
 bits
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
-
-VIRTIO-70
-
-Cc: Patrick Durusau <patrick@durusau.net>
- } \\
-\hline
-303 & 02 Mar 2014 & Michael S. Tsirkin & { legacy interface: move to termi=
nology
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
-
-VIRTIO-64
-
-Cc: Patrick Durusau <patrick@durusau.net
- } \\
-\hline
-302 & 02 Mar 2014 & Michael S. Tsirkin & { introduction: add link to 0.9.5=
 specification
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
-
-this version replaces it, so it's a non normative reference.
-
-VIRTIO-69
-
-note: the link is added here but isn't used yet: will be used
-
-when we cleanup terminology definitions, by
-
-addressing VIRTIO-64
-
-Cc: Patrick Durusau <patrick@durusau.net
- } \\
-\hline
-301 & 02 Mar 2014 & Michael S. Tsirkin & { non-transitional devices with l=
egacy drivers
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
-
-weaken hacky requirements helpful for graceful failure
-
-for non transitional PCI devices from MUST to SHOULD.
-
-It's nice to have but it's not like it makes things work, and you
-
-can avoid trouble simply by using the most recent drivers.
-
-also move them out to a separate section
- } \\
-\hline
-300 & 02 Mar 2014 & Michael S. Tsirkin & { conformance: document two types=
 of devices
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
-
-document that there are two conformance levels
- } \\
-\hline
-299 & 02 Mar 2014 & Michael S. Tsirkin & { legacy device initialization: c=
onfirmance statements
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
- } \\
-\hline
-298 & 02 Mar 2014 & Michael S. Tsirkin & { legacy virtqueue layout: confir=
mance
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
- } \\
-\hline
-297 & 02 Mar 2014 & Michael S. Tsirkin & { legacy: make all notes on endia=
n-ness confirmance clauses
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
- } \\
-\hline
-296 & 02 Mar 2014 & Michael S. Tsirkin & { legacy feature bits: confirmanc=
e statements
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
- } \\
-\hline
-295 & 02 Mar 2014 & Michael S. Tsirkin & { leacy: layout detection confirm=
ance
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
- } \\
-\hline
-294 & 02 Mar 2014 & Michael S. Tsirkin & { legacy pci layout: extra confir=
mance statement
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
- } \\
-\hline
-293 & 02 Mar 2014 & Michael S. Tsirkin & { legacy pci layout: confirmance =
statements
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
- } \\
-\hline
-292 & 02 Mar 2014 & Michael S. Tsirkin & { legacy: make message framing no=
rmative
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
-
-TODO: we really should be more specific
- } \\
-\hline
-291 & 02 Mar 2014 & Michael S. Tsirkin & { legacy: make note on legacy VQ =
endian-ness normative
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
- } \\
-\hline
-290 & 02 Mar 2014 & Michael S. Tsirkin & { Legacy Interface: Device Config=
uration Space
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
-
-legacy has no generation field.
-
-add SHOULD statement to document multi-byte field
-
-access rules.
- } \\
-\hline
-289 & 02 Mar 2014 & Michael S. Tsirkin & { legacy: clarify general note on=
 endian-ness
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
-
-this is a non normative section.
-
-we merely mention that details are given
-
-for each device.
- } \\
-\hline
-288 & 02 Mar 2014 & Michael S. Tsirkin & { content: explain that legacy su=
pport is optional
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
- } \\
-\hline
-287 & 02 Mar 2014 & Michael S. Tsirkin & { drop /* LEGACY version was not =
little endian */
-
-Two issues with the comment:
-
-=09- it mixes legacy documentation in main part of the spec
-
-=09- it says what format *isn't* - instead of what it *is*
-
-Now that we have documented that LE can mean
-
-legacy endian, there's no need for the comment.
-
-Resolves issues:
-
-=09VIRTIO-58
-
-Change accepted on Virtio TC Meeting Minutes: Feb 25, 2014
- } \\
-\hline
-286 & 27 Feb 2014 & Rusty Russell & { Fixed path of linux version of virti=
o_ring.h
- } \\
-\hline
-285 & 26 Feb 2014 & Pawel Moll & { mmio: Clarify normative requirement on =
QueueNum
-
-Minor fix: add explicit reference to QueueNumMax in the
-
-normative paragraph describing QueueNum.
- } \\
-\hline
-284 & 26 Feb 2014 & Pawel Moll & { mmio: Fix double register macro
-Minor fix: commit 238 wrapped register names in \textbackslash field\{\}s
-
-and modified one of the register table macros, but missed
-
-the other one.
- } \\
-\hline
-283 & 26 Feb 2014 & Pawel Moll & { mmio: Fix Device Tree example
-
-Minor fix: the size of 0x100 was obviously wrong,
-
-as it didn't allow for configuration space.
- } \\
-\hline
-282 & 26 Feb 2014 & Cornelia Huck & { introduction: typo in terminology se=
ction
-
-s/device/driver/ for the transitional driver description.
- } \\
-\hline
-281 & 26 Feb 2014 & Rusty Russell & { ccw: Fix requirements for processing=
 adapter interrupts.
-
-We currently mandate that the driver clears the summary indicator
-
-before processing the queue indicator; this is bogus, as the requirement
-
-for interrupt avoidance is rather that the driver unsets the summary
-
-indicator before before it stops looking at the queue indicator.
-
-In fact, the best way to get a race-free implementation of the interrupt
-
-handler is to process the queue indicators twice; let's add a recommondati=
on
-
-to do that.
- } \\
-\hline
-280 & 26 Feb 2014 & Rusty Russell & { VIRTIO-45: Add a reserved ID for Tim=
er/Clock device
-
-Just add a reserved ID for Timer/Clock device. There is no work
-
-on it yet but it is nice to have the ID which could be used safely
-
-in preliminary implementations.
- } \\
-\hline
-279 & 26 Feb 2014 & Rusty Russell & { VIRTIO-28: Deprecate balloon device,=
 add number for new one.
- } \\
-\hline
-278 & 26 Feb 2014 & Rusty Russell & { Feedback: VIRTIO-77 Conformance clau=
se.
-
-Now we have grouped all the normative statements, the conformance
-
-clauses for drivers and devices can simply reference them.
- } \\
-\hline
-277 & 26 Feb 2014 & Rusty Russell & { Feedback: Separate normative require=
ments for Reserved Feature Bits.
- } \\
-\hline
-276 & 26 Feb 2014 & Rusty Russell & { Feedback: SCSI: Separate normative a=
nd descriptive texts.
-
-This could use some more rigour, I think: there are still many
-
-implied requirements which could be called out.
- } \\
-\hline
-275 & 26 Feb 2014 & Rusty Russell & { Feedback: console \& entropy: separa=
te normative and descriptive texts.
- } \\
-\hline
-274 & 26 Feb 2014 & Rusty Russell & { Feedback: block: separate normative =
and descriptive text.
- } \\
-\hline
-273 & 26 Feb 2014 & Rusty Russell & { Feedback: net: separate normative an=
d instructional text.
- } \\
-\hline
-272 & 26 Feb 2014 & Rusty Russell & { Feedback: CCW: Separate normative an=
d descriptive sections.
- } \\
-\hline
-271 & 26 Feb 2014 & Rusty Russell & { Feedback: MMIO: Separate normative a=
nd descriptive text.
-
-The section on initialization is now non-normative.
- } \\
-\hline
-270 & 26 Feb 2014 & Rusty Russell & { Feedback: PCI: Separate explanatory =
and normative text.
-
-Rather than treat selectors 0 and 1 as special, the wording for features
-
-is made more general (though still the same effect).
-
-I split the interrupt handler into a separate subsection: it was
-
-misleading because it didn't handle configuration interrupts until
-
-the next section.  It's also non-normative.
- } \\
-\hline
-269 & 26 Feb 2014 & Rusty Russell & { Feedback: Separate the rest of chapt=
er 2 into normative vs explanatory.
-
-The big change here is in introducing new subsections for interrupt and no=
tification
-
-suppression, and moving all requirements into them.
-
-The example processing loop is also moved into a note, to show clearly
-
-that it's not normative.
- } \\
-\hline
-268 & 26 Feb 2014 & Rusty Russell & { Feedback: Normative split for Basic =
Facilities of a Virtio Device / Virtqueues / Message Framing
- } \\
-\hline
-267 & 26 Feb 2014 & Rusty Russell & { Feedback: Normative split in Basic F=
acilities of a Virtio Device / Virtqueues
- } \\
-\hline
-266 & 26 Feb 2014 & Rusty Russell & { Feedback: split Basic Facilities fea=
ture bits and config space into normative.
-
-Split text into descriptive and normative.
- } \\
-\hline
-265 & 26 Feb 2014 & Rusty Russell & { Feedback: add normative marker.
-From \url{http://docs.oasis-open.org/templates/TCHandbook/ConformanceGuide=
lines.html:}
-
-   Normative statements MUST be referenceable so that a statement may be
-
-   referenced from another part of a specification, but more importantly
-
-   so they can be referenced from Conformance Clauses.
- } \\
-\hline
-264 & 26 Feb 2014 & Rusty Russell & { Feedback: 2.1 Device Status field: S=
eparate description from normative.
-
-Start with explanation, progress to normative requirements.
- } \\
-\hline
-263 & 26 Feb 2014 & Rusty Russell & { Feedback: move legacy/transitional d=
efinitions into terminology.
- } \\
-\hline
-262 & 26 Feb 2014 & Rusty Russell & { Feedback: hoist the one legacy-relat=
ed requirement out of legacy section.
-
-This requirement applies to any system which *did* have legacy drivers.
- } \\
-\hline
-261 & 26 Feb 2014 & Rusty Russell & { Feedback: add old draft to normative=
 references (VIRTIO-77)
- } \\
-\hline
-260 & 26 Feb 2014 & Rusty Russell & { Feedback: use proper list in introdu=
ction (VIRTIO-82)
-
-Also avoid extra spacing before footnote markers.
- } \\
-\hline
-259 & 26 Feb 2014 & Rusty Russell & { Feedback: move new device design sec=
tion to Appendix.
-
-It's non-normative.
- } \\
-\hline
-258 & 26 Feb 2014 & Rusty Russell & { Feedback: Bug TAB-553 (VIRTIO-76)
-
-Haven't marked them non-normative yet, but it makes sense to put the heade=
r
-
-in an appendix.
- } \\
-\hline
-257 & 26 Feb 2014 & Rusty Russell & { Feedback: TAB-555 Bad sub-sectioning=
 (VIRTIO-80)
- } \\
-\hline
-256 & 26 Feb 2014 & Rusty Russell & { Feedback: TAB-557 Spelling errors, e=
tc (VIRTIO-75)
- } \\
-\hline
-255 & 26 Feb 2014 & Rusty Russell & { PCI: better document driver and devi=
ce requirements
-
-Feedback:
-
-10) 4.1.3.1.2 Queue Vector Configuration
-
-Some of the information from section 8.4 needs to be moved to
-
-here, for example that the device may have an MSI-X table size
-
-other than 2048.
-
-Otherwise, this reads as though the MSI-X table must always have
-
-2048 entries.
-
-11) Please explicitly describe the device behavior when writing
-
-a vector value beyond the MSI-X table size.
-
-Address these comments.
-
-Cc: Arun Subbarao <asubbarao@lnxw.com>
- } \\
-\hline
-254 & 26 Feb 2014 & Rusty Russell & { feedback: minor wording cleanups
-
-We already mention requirement for natural width
-
-accesses for non device specific configuration.
-
-Don't repeat this in legacy section.
-
-Further, mention virtio pci structure in
-
-preamble to help link sections together.
-
-Cc: Arun Subbarao <asubbarao@lnxw.com>
-
-Conflicts:
-
-=09content.tex
- } \\
-\hline
-253 & 26 Feb 2014 & Rusty Russell & { SCSI: fix up more fields.
-Some missing \textbackslash field\{\} markings, and a few redundant "the X=
XX field".
- } \\
-\hline
-252 & 20 Feb 2014 & Rusty Russell & { SCSI: missing space.
- } \\
-\hline
-251 & 19 Feb 2014 & Rusty Russell & { Gratuitous Packet Sending: clarify w=
ording.
-
-The device can ask, not the driver.
- } \\
-\hline
-250 & 19 Feb 2014 & Rusty Russell & { net: fix incorrect reference.
-
-It pointed into the block section for some reason.
- } \\
-\hline
-249 & 13 Feb 2014 & Cornelia Huck & { ccw: padding annotations
-
-Remove __packed__ annotation from all ccw structures that don't need it,
-
-and make the length requirements explicit for those that do.
-
-This is the part of the patch to resolve VIRTIO-56 that had been missed.
- } \\
-\hline
-248 & 12 Feb 2014 & Michael S. Tsirkin & { PCI: minor wording change
-
-Since access width requirement is a confirmance clause, make it
-
-explicit that it applies to 4,2 and 1 byte fields.
-
-Also explain what happens to fields of other widths (such as
-
-the 6 byte MAC).
- } \\
-\hline
-247 & 12 Feb 2014 & Michael S. Tsirkin & { content: more strict confirmanc=
e language
-
-Correct new language to explicitly use MAY/SHOULD/MUST
-
-in more places or simply drop the somewhat vague "can" where
-
-we are describing the only way to operate the device.
-
-Most of the changes are in the PCI section.
- } \\
-\hline
-246 & 12 Feb 2014 & Michael S. Tsirkin & { introduction: address lnovich c=
omments
-
-generally list of buses is out of date, list all supported buses.
-
-Drop explicit mention of lguest since it's not part of the spec.
- } \\
-\hline
-245 & 12 Feb 2014 & Michael S. Tsirkin & { abstract: address lnovich comme=
nt
-
-lnovich@redhat.com suggested rewording abstract,
-
-making the following point:
-
-. from what point of view is virtio like a physical device?
-
-  it's very different from host POV
-
-. "the guest" appears out of nowhere. It's the guest that runs
-
-  in the vm of course.
-
-. "not all that different" means similar so there's not need to
-
-  be verbose
-
-Address this comment
- } \\
-\hline
-244 & 12 Feb 2014 & Rusty Russell & { VIRTIO-55: Add a reserved ID for GPU=
 devices
-
-As existing work on virtio-gpu is using device ID 16, reflect this in
-
-the spec. This closes out VIRTIO-55.
-
-As per minutes:
-        \url{https://lists.oasis-open.org/archives/virtio/201402/msg00121.=
html}
- } \\
-\hline
-243 & 12 Feb 2014 & Rusty Russell & { Fix S390 normative references.
-
-As pointed out in TAB-539 and TAB-540:
-
-- Add an URL to the documents. (Unfortunately, there is no link that
-
-  always points to the latest version.)
-
-- State that we include any future revisions as well.
-
-As per minutes:
-        \url{https://lists.oasis-open.org/archives/virtio/201402/msg00121.=
html}
- } \\
-\hline
-242 & 12 Feb 2014 & Rusty Russell & { ccw: Further use of RFC2119 language=
.
-
-Some more instances of MAY and SHOULD, as reported in TAB comments
-
-TAB-548 and TAB-550.
-
-As per minutes:
-        \url{https://lists.oasis-open.org/archives/virtio/201402/msg00121.=
html}
- } \\
-\hline
-241 & 12 Feb 2014 & Rusty Russell & { PCI: explicitly document ISR status =
field
-
-Feedback on ISR status register:
-
-=09It would be helpful if this section provided the meaning of each
-
-=09bit in the register.
-
-ISR use is scattered all around the place.
-
-Add a section describing the format and semantics.
-
-[ Merged to combine with new ISR-specific section --RR ]
-
-As per minutes:
-        \url{https://lists.oasis-open.org/archives/virtio/201402/msg00121.=
html}
-
-Cc: Arun Subbarao <asubbarao@lnxw.com>
- } \\
-\hline
-240 & 12 Feb 2014 & Rusty Russell & { PCI: consistent device/PCI configura=
tion space
-
-Re section:
-
-4.1.3.4 Notification of Device Configuration Changes
-
-Feedback:
-
-=09Please use "PCI configuration space" and "device configuration
-
-=09state" consistently, without abbreviation. For example, from the
-
-=09first sentence it looks like "device configuration state" can be
-
-=09changed, but the first bullet claims it's "configuration space".
-
-=09So, which one? Does "configuration space" mean "PCI configuration
-
-=09space" or is it a synonym for "device configuration state"?
-
-=09Because those are two different things; the driver needs to know
-
-=09what exactly to rescan.
-
-As per minutes:
-        \url{https://lists.oasis-open.org/archives/virtio/201402/msg00121.=
html}
-
-Cc: Arun Subbarao <asubbarao@lnxw.com>
- } \\
-\hline
-239 & 12 Feb 2014 & Rusty Russell & { Feedback \#8: Applied.
-
-[ Includes fixup! removing MSI-X ]
-
-As per minutes:
-        \url{https://lists.oasis-open.org/archives/virtio/201402/msg00121.=
html}
- } \\
-\hline
-238 & 12 Feb 2014 & Rusty Russell & { Feedback \#7: Applied
-
-Some minor merging required.
-
-As per minutes:
-    \url{https://lists.oasis-open.org/archives/virtio/201402/msg00121.html=
}
- } \\
-\hline
-237 & 12 Feb 2014 & Rusty Russell & { Feedback \#6: Applied
-
-As per minutes:
-=09\url{https://lists.oasis-open.org/archives/virtio/201402/msg00121.html}
- } \\
-\hline
-236 & 12 Feb 2014 & Rusty Russell & { Feedback \#5: Applied.
-
-As per minutes:
-=09\url{https://lists.oasis-open.org/archives/virtio/201402/msg00121.html}
- } \\
-\hline
-235 & 12 Feb 2014 & Rusty Russell & { Feedback \#4: applied.
-
-As per minutes:
-=09\url{https://lists.oasis-open.org/archives/virtio/201402/msg00121.html}
- } \\
-\hline
-234 & 12 Feb 2014 & Rusty Russell & { PCI: minor changes for previous patc=
h.
- } \\
-\hline
-233 & 12 Feb 2014 & Rusty Russell & { PCI: rearrange it all
-
-This is the re-arrangement originally suggested by Rusty,
-
-except I made some fixes and also tweaked a couple of places
-
-where behaviour changes where suggested - if we want these,
-
-they should go in separately.
-
-Rearrange discovery section to make it clearer what goes on.
-
-Wording changes MUST/MAY/etc.  Clarify cfg gateway use.  No
-
-behavioural changes.
-
-[ Merged "fixup! PCI: rearrange it all" --RR ]
-
-As per minutes:
-        \url{https://lists.oasis-open.org/archives/virtio/201402/msg00121.=
html}
- } \\
-\hline
-232 & 12 Feb 2014 & Rusty Russell & { PCI: rearrange it all
-
-This is the re-arrangement originally suggested by Rusty,
-
-except I made some fixes and also tweaked a couple of places
-
-where behaviour changes where suggested - if we want these,
-
-they should go in separately.
-
-Rearrange discovery section to make it clearer what goes on.
-
-Wording changes MUST/MAY/etc.  Clarify cfg gateway use.  No
-
-behavioural changes.
- } \\
-\hline
-231 & 12 Feb 2014 & Rusty Russell & { C struct specifications.
-
-Explicitly specify that our C struct specifications are without padding,
-
-and add some definitions for our integer data types.
-
-[ Rusty - added /* comments */ and removed redundant old le* explanation ]
- } \\
-\hline
-225 & 10 Feb 2014 & Rusty Russell & { REVERT LAST 15 JUNK COMMITS.
-
-Back to r211.  It's been a long day.
- } \\
-\hline
-224 & 10 Feb 2014 & Rusty Russell & { patch feedback-8-9.patch
- } \\
-\hline
-223 & 10 Feb 2014 & Rusty Russell & { patch feedback-8-7.patch
- } \\
-\hline
-222 & 10 Feb 2014 & Rusty Russell & { patch feedback-8-6.patch
- } \\
-\hline
-221 & 10 Feb 2014 & Rusty Russell & { patch feedback-8-5.patch
- } \\
-\hline
-220 & 10 Feb 2014 & Rusty Russell & { feedback: s/virtio header/virtio com=
mon configuration/
-
-While most places now sat virtio common configuration
-
-structure, some places still use the term virtio header.
-
-Since it's not necessarily before the
-
-common configuration anymore, rename it
-
-to virtio common configuration structure for consistency.
-
-Cc: Arun Subbarao <asubbarao@lnxw.com>
- } \\
-\hline
-219 & 10 Feb 2014 & Rusty Russell & { We'll add more non-normative section=
s with hints for
-
-implementing registers such as PCI class, status
-
-and command registers.
- } \\
-\hline
-218 & 10 Feb 2014 & Rusty Russell & { example code does not have to be opt=
imal but it
-
-seems cleaner to disable interrupts after we
-
-recheck the ring empty state.
- } \\
-\hline
-217 & 10 Feb 2014 & Rusty Russell & { patch feedback-7-orig.patch
- } \\
-\hline
-216 & 10 Feb 2014 & Rusty Russell & { patch feedback-6.patch
- } \\
-\hline
-215 & 10 Feb 2014 & Rusty Russell & { patch feedback-5.patch
- } \\
-\hline
-214 & 10 Feb 2014 & Rusty Russell & { patch feedback-4.patch
- } \\
-\hline
-213 & 10 Feb 2014 & Rusty Russell & { PCI Section Rework
-
-1) Minor changes from must to MUST etc.
-
-2) More references using \textbackslash ref.
-
-3) Move section on capabilities first, before we talk about the common
-
-   config layout.  The previous order made sense for legacy.
-
-4) Make explicit subsections for each type of capability and move more
-
-   information into them.
-
-5) Make it clear that there must be one or more.
-
-6) Include 'struct virtio_pci_cap cap;' in struct virtio_pci_cfg_cap to
-
-   match virtio_pci_notify_cap.
-
-7) Explicitly note there's no way to negotiate the queue size for a
-
-   legacy device.
-
-8) Fix old language on config change event: config is not in the pci
-
-   configuration space.
-
-9) Explicitly state what the driver should do to use virtio_pci_cfg_cap.
- } \\
-\hline
-212 & 10 Feb 2014 & Rusty Russell & { C struct specifications.
-
-Explicitly specify that our C struct specifications are without padding,
-
-and add some definitions for our integer data types.
-
-[ Rusty - added /* comments */ and removed redundant old le* explanation ]
- } \\
-\hline
-207 & 07 Feb 2014 & Rusty Russell & { Cleanup and setup clarifications
-
-1) Explicitly allow drivers to read config space during feature
-
-   negotiation.
-
-2) Add the concept of a "live" virtqueue, and explicitly disallow
-
-   moving it backwards or changing descriptors.
- } \\
-\hline
-204 & 07 Feb 2014 & Rusty Russell & { block: legacy SCSI command fix.
-
-When describing the historical layout requirements, it says
-
- "status field is a separate read-only buffer of size 1 byte, by itself."
-
-That's clearly wrong, as it says above "The final status byte is written b=
y the device"
- } \\
-\hline
-203 & 06 Feb 2014 & Rusty Russell & { whitespace: make all examples uninde=
nted, and avoid tabs.
-
-This makes the formatting far nicer.  Applying now as it touches almost
-
-all examples and layouts, so we can rebase future changes on top of
-
-common ground.
-
-(Based on feedback from Thomas Huth for one example, and generalized).
- } \\
-\hline
-201 & 31 Jan 2014 & Rusty Russell & { 3.2.1: Language tightening.
-
-1) Lots of "we", replace with "the driver".
-
-2) Use MAY and MUST NOT for spurious notifications.
-
-3) Don't refer to PCI configuration space for notification.
- } \\
-\hline
-198 & 29 Jan 2014 & Pawel Moll & { 4.1.2.5: Legacy: PCI Device Layout: fix=
 PCI header fields order
-
-The order of the fields in the legacy PCI header seems to get
-
-messed up in the new spec, with the "Queue Address" moved
-
-behind "Queue Notify". According to the 0.9.5 version of the spec
-
-it should be:
-
-* Device Features 32
-
-* Driver Features 32
-
-* Queue Address 32
-
-* Queue Size 16
-
-* Queue Select 16
-
-* Queue Notify 16
-
-* Device Status 8
-
-* ISR Status 8
-
---
-
-1.8.3.2
- } \\
-\hline
-197 & 29 Jan 2014 & Rusty Russell & { Feedback \#3: Feedback from Pranavku=
mar Sawargaonkar (VIRTIO_CONSOLE_F_EMERG_WRITE)
-
-Document: virtio-v1.0-csprd01
-
-Number: 3
-
-Date: Tue, 21 Jan 2014 15:09:54 +0530
-Link to Mail: \url{https://lists.oasis-open.org/archives/virtio-comment/20=
1401/msg00037.html}
-
-Commenter name: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
-
-Approved at meeting 2014-01-28:
-=09\url{https://lists.oasis-open.org/archives/virtio/201401/msg00054.html}
- } \\
-\hline
-196 & 29 Jan 2014 & Rusty Russell & { Feedback \#2: More feedback from  Th=
omas Huth
-
-Document: virtio-v1.0-csprd01
-
-Number: 2
-
-Date: Fri, 10 Jan 2014 13:49:49 +0100
-Link to Mail: \url{https://lists.oasis-open.org/archives/virtio-comment/20=
1401/msg00001.html}
-
-Commenter name: Thomas Huth <thuth@linux.vnet.ibm.com>
-
-Approved at meeting 2014-01-28:
-=09\url{https://lists.oasis-open.org/archives/virtio/201401/msg00054.html}
- } \\
-\hline
-195 & 29 Jan 2014 & Rusty Russell & { Feedback \#1: fixes from Thomas Huth
-
-Document: virtio-v1.0-csprd01
-
-Number: 1
-
-Date: Fri, 10 Jan 2014 11:01:44 +0100
-Link to Mail: \url{https://lists.oasis-open.org/archives/virtio-comment/20=
1401/msg00000.html}
-
-Commenter name: Thomas Huth <thuth@linux.vnet.ibm.com>
-
-Approved at meeting: 2014-01-28
-=09\url{https://lists.oasis-open.org/archives/virtio/201401/msg00054.html}
- } \\
-\hline
-194 & 28 Jan 2014 & Pawel Moll & { mmio: Move QueueReady register from off=
set 0x03c to 0x044
-
-Legacy devices have QueueAlign register at 0x03c. To stay
-
-on the safe side and avoid any potential clashes (also to
-
-be able to abort any wrong writes), move it to previously
-
-unused offset 0x044.
- } \\
-\hline
-193 & 23 Jan 2014 & Cornelia Huck & { virtio-ccw: fix set_revision payload=
 definition
-
-The members of struct virtio_rev_info are big endian: use be16 types.
- } \\
-\hline
-191 & 23 Jan 2014 & Rusty Russell & { Formatting: fix feature bits for con=
sole device.
-
-Make them a description list like every other device.
- } \\
-\hline
-190 & 23 Jan 2014 & Rusty Russell & { Michael's patch adding MQ support ad=
ded some u16s; they are u16 in
-
-legacy mode but should be le16 for modern devices.
- } \\
-\hline
-185 & 17 Jan 2014 & Rusty Russell & { net/multiqueue: tighten wording
- } \\
-\hline
-184 & 17 Jan 2014 & Rusty Russell & { Fixes for first WD front page.
-
-Based on feedback from Paul Knight <paul.knight@oasis-open.org>.
- } \\
-\hline
-179 & 03 Jan 2014 & Pawel Moll & { mmio: Obviously wrong notification regi=
ster name
-
-The "4.2.3.3 Notifying The Device" section said "writing
-
-the index of the updated queue to the QueueNum". This
-
-is obviously wrong - should read "QueueNotify".
- } \\
-\hline
-178 & 16 Dec 2013 & Pawel Moll & { title \& acknowledgements: Make ARM les=
s limited
-
-... by removing the "Limited" bit of the name.
- } \\
-\hline
-177 & 16 Dec 2013 & Pawel Moll & { 2.3.2 MMIO: Configuration space offset =
corrected
-
-The offset in the MMIO configuration space description
-
-(table 4.1) became wrong at some time (0x0fff). Fixed.
- } \\
-\hline
-176 & 12 Dec 2013 & Pawel Moll & { 2.3.2 MMIO: Notifications \& interrupts=
 clarifications
-
-(Hopefully) clarified the way notifications are being
-
-passed between the device and the driver and about
-
-the meaning of the interrupt registers.
- } \\
-\hline
-175 & 12 Dec 2013 & Pawel Moll & { 1. Introduction: Removed left-over "PCI=
"
-
-The "Extensible" paragraph of the introduction still
-
-referred to "Virtio PCI devices". Changed to
-
-"Virtio devices".
- } \\
-\hline
-174 & 12 Dec 2013 & Pawel Moll & { 2.3.2 MMIO: Further clarifications
-
-Clarified driver behaviour for out-of-spec MagicValue,
-
-Version and DeviceID values.
- } \\
-\hline
-173 & 12 Dec 2013 & Cornelia Huck & { ccw: feature bit endianness
-
-In contrast to the other values transmitted in ccw payload, feature bits
-
-are little endian. Fix it in the structure definition.
- } \\
-\hline
-172 & 12 Dec 2013 & Cornelia Huck & { ccw: clarify passing of subchannel i=
d
-
-Make clear that the upper half of the register must be ignored, just
-
-like normal I/O instructions do.
- } \\
-\hline
-171 & 12 Dec 2013 & Cornelia Huck & { ccw: Tighten specification language.
-
-must -> MUST changes, removed inappropriate mays.
- } \\
-\hline
-170 & 09 Dec 2013 & Pawel Moll & { 2.3.2 MMIO: LaTeXisation
-
-Converter the register layout descriptions into
-
-tables.
-
-Also hardened the specification language, using
-
-MUSTs and MUST NOTs.
- } \\
-\hline
-168 & 09 Dec 2013 & Michael S. Tsirkin & { commands-pdf.tex: align title p=
age
-
-Section titles are currently misaligned on the title
-
-page. This patch aligns them back.
- } \\
-\hline
-167 & 09 Dec 2013 & Michael S. Tsirkin & { net: document VIRTIO_NET_F_MAC_=
ADDR
-
-VIRTIO-50
-
-    virtio-spec: set mac address by a new vq command
-
-Approved Dec 3, 2013
- } \\
-\hline
-166 & 09 Dec 2013 & Michael S. Tsirkin & { net: add _F_MQ support
-
-VIRTIO-49
-
-Includes git commits:
-
-    virtio-spec: fix two typos
-
-    virtio-spec: virtio network device multiqueue support
-
-    net: add note that you can defer rx queue init until mq enable.
-
-Approved Dec 3, 2013
- } \\
-\hline
diff --git a/cl-csprd03.tex b/cl-csprd03.tex
deleted file mode 100644
index 81f9bfb..0000000
--- a/cl-csprd03.tex
+++ /dev/null
@@ -1,400 +0,0 @@
-399 & 27 Jun 2014 & Michael S. Tsirkin & { changelog: fill changelog since=
 draft2
-
-This will make review easier.
- } \\
-\hline
-398 & 27 Jun 2014 & Michael S. Tsirkin & { acknowledgements: add draft 3 r=
eviewers, sort
-
-Add new reviewers and sort by name.
- } \\
-\hline
-397 & 27 Jun 2014 & Michael S. Tsirkin & { add draft2 acknowledgements
-
-List people that provided comments on draft01 in the
-acknowledgements section. Might be a nice way to encourage
-reviews.
- } \\
-396 & 26 Jun 2014 & Michael S. Tsirkin & { diff: back to green for added t=
ext
-
-using blue does not work well for html
-
- } \\
-\hline
-393 & 26 Jun 2014 & Michael S. Tsirkin & { makediff: cleanup using begingr=
oup/endgroup
-
-Pawel Moll found a way to work around xetex bugs
-without mangling latexdiff output using perl:
-
-- define DIFbegin/DIFFend commands in preample
-
-- pass --config FLOATENV=3D to latexdiff
-
-Use this in preference to the fixupdiff perl script.
-
- } \\
-\hline
-391 & 26 Jun 2014 & Michael S. Tsirkin & { more latexdiff hacks
-
-- change link color from green to pinegreen. Looks better to me.
-
-- split footnotes out from their text, so that latexdiff
-  does not consider them as a unit
-
-- mark field command as safe for latexdiff, otherwise it's not shown in re=
d
-
-- hack adding DIFaddtext within footnotes could not handle
-  case where latexdiff inserted multiple DIFadd within the
-  footnote. Instead, detect when footnote is within
-  DIFaddbegin/DIFdelbegin, add an extra DIFaddbegin/DIFdelbegin
-  within the footnote.
-
- } \\
-\hline
-390 & 26 Jun 2014 & Michael S. Tsirkin & { diffpreamble: fix colors for li=
nks within diff
- } \\
-\hline
-389 & 26 Jun 2014 & Michael S. Tsirkin & { work around xetex bug
-
-Too many \textbackslash color directives produce corrupted output
-and this warning:
-
-WARNING ** Color stack overflow. Just ignore.
-
-Use script to reduce \# of these directives.
-
- } \\
-\hline
-388 & 26 Jun 2014 & Michael S. Tsirkin & { diffpreamble: remove duplicate =
text
-
-latexdiff adds some
-
- } \\
-\hline
-387 & 26 Jun 2014 & Michael S. Tsirkin & { makediffpdf.sh: tool to create =
marked-up diff
-
-make pdf diff using latexpand and latexdiff-fast
-styles are set in diffpreamble.tex
-in diff, links are coloured green instead of blue
-
-Must be run within a git-svn clone of the spec repository.
-
-Note: latexdiff has --flatten option, this and options
-to select diff style don't seem to work well.
-
-So flatten by script myself, and add our own preamble.
-
- } \\
-\hline
-386 & 25 Jun 2014 & Michael S. Tsirkin & { pci: minor fomatting tweak
-
-Make table look better. Drop spaces that make
-latexdiff stumble.
-
- } \\
-\hline
-385 & 25 Jun 2014 & Michael S. Tsirkin & { fixup pci: switch from subsyste=
m id to device id
-
-Patch sent to list (and applied by Rusty in
-
-    pci: switch from subsystem id to device id
-
-) did not actually implement what commit log said
-it implements.
-
-The result is wrong for transitional devices:
-
-Adding 0xfff works for for net+block only;
-
-for transitional pci devices there is no fixed scheme:
-\~{}/projects/qemu/include \# grep VIRTIO_ID hw/virtio/*.h
-
-hw/virtio/virtio-balloon.h:\#define VIRTIO_ID_BALLOON 5
-
-hw/virtio/virtio-blk.h:\#define VIRTIO_ID_BLOCK 2
-
-hw/virtio/virtio-net.h:\#define VIRTIO_ID_NET   1
-
-hw/virtio/virtio-rng.h:\#define VIRTIO_ID_RNG    4
-
-hw/virtio/virtio-scsi.h:\#define VIRTIO_ID_SCSI  8
-
-hw/virtio/virtio-serial.h:\#define VIRTIO_ID_CONSOLE             3
-
-\~{}/projects/qemu/include \# grep VIRTIO hw/pci/*.h
-
-hw/pci/pci.h:\#define PCI_DEVICE_ID_VIRTIO_NET         0x1000
-
-hw/pci/pci.h:\#define PCI_DEVICE_ID_VIRTIO_BLOCK       0x1001
-
-hw/pci/pci.h:\#define PCI_DEVICE_ID_VIRTIO_BALLOON     0x1002
-
-hw/pci/pci.h:\#define PCI_DEVICE_ID_VIRTIO_CONSOLE     0x1003
-
-hw/pci/pci.h:\#define PCI_DEVICE_ID_VIRTIO_SCSI        0x1004
-
-hw/pci/pci.h:\#define PCI_DEVICE_ID_VIRTIO_RNG         0x1005
-
-hw/pci/pci.h:\#define PCI_DEVICE_ID_VIRTIO_9P          0x1009
-
-I am guessing TC went by commit log when it approved the change,
-so fixing it up directly.
-
-Cc: Andrew Thornton <andrewth@google.com>
-
-Cc: Rusty Russell <rusty@ozlabs.org>
-
-Cc: Gerd Hoffmann <kraxel@redhat.com>
-
- } \\
-\hline
-384 & 17 Jun 2014 &  & { content.tex: VIRTIO-106: mention possibility of f=
ailing TMFs
-
-This completes the review of virtio-scsi based on observations
-from Google.
-
- } \\
-\hline
-383 & 16 Jun 2014 &  & { fix erroneous reference to Subsystem Device ID
-
-Subsystem device ID only exists for PCI.
-
- } \\
-\hline
-382 & 16 Jun 2014 & Rusty Russell & { small virtio-serial fix
-
-nr_ports does not exist in the spec.
-
- } \\
-\hline
-381 & 09 Jun 2014 &  & { virtio-scsi: support well-known logical units
-
-The REPORT LUNS well-known logical unit is useful because it lets you
-retrieve information about all targets with a single command.  It
-also provides an easy way to send a no-op request.
-
- } \\
-\hline
-380 & 09 Jun 2014 &  & { consistent formatting of footnotes
-
-Put the indicator before punctuation, and terminate the footnote with
-a period.
-
- } \\
-\hline
-379 & 09 Jun 2014 &  & { virtio-scsi: additional SHOULDification
-
- } \\
-\hline
-378 & 09 Jun 2014 &  & { virtio-scsi: fixes to protection information
-
-pi_bytesin is in the device-readable section.  Document lack of residual
-field.  Use le32 instead of u32.
-
-This matches the new patch series that Nicholas sent for vhost-scsi.
-
-Cc: <nab@daterainc.com>
-
- } \\
-\hline
-377 & 05 Jun 2014 & Rusty Russell & { PCI: remove duplicate paragraph.
-
-I chose the one which used the full nomenclature.
-
- } \\
-\hline
-376 & 05 Jun 2014 & Rusty Russell & { pci: switch from subsystem id to dev=
ice id
-
-Switch virtio pci to use standard device id instead of using the
-subsystem id.
-
-Unfortunately, there's no system to the way KVM allocated
-device IDs to virtio devices, we'll just have to
-specify these using a table, and use a new range for
-future devices. For existing devices this results in
-two possible IDs that all drivers will need to match.
-Unfortunate, but the cost is small.
-
-As a nice side effect, this allows us to make non-transitional
-devices use IDs 0x40 and up, this reduces even further the
-chance that a non transitional device will match legacy drivers.
-
-And, it's probably a good idea to allow drivers to match
-specific subsystem IDs if they
-
-want to, so relax requirement for drivers to match all
-subsystem/vendor ID configurations, but allow them to do so.
-To avoid confusion, say "PCI Device ID" and
-"PCI Subsystem ID" everywhere, prefix "PCI"
-for other standard registers, for consistency.
-
-VIRTIO-102
-
-Note: issue reporter suggested 0x10XX where XX is the virtio
-device ID. This would conflict with legacy devices, which seem
-to have used 7 IDs in the range 0x1000 to 0x103f without any
-system. Let's use a new range 0x1040 to 0x107f for
-non-transitional devices, and add a table documenting the
-transitional IDs used by in practice.
-
-(Approved at 2014-06-04 meeting:
-
-  \url{https://lists.oasis-open.org/archives/virtio/201406/msg00013.html} =
)
-
-Cc: Andrew Thornton <andrewth@google.com>
-
- } \\
-\hline
-375 & 05 Jun 2014 & Rusty Russell & { pci: set ISR bit on config change wi=
th MSI-X
-
-config changes are slow path anyway, so we
-can as well set ISR bit to help drivers detect changes.
-This allows sharing config interrupts which is what
-issue reporter seems to ask for.
-
-VIRTIO-104
-
-(Approved at 2014-06-04 meeting:
-
-  \url{https://lists.oasis-open.org/archives/virtio/201406/msg00013.html} =
)
-
- } \\
-\hline
-374 & 01 Jun 2014 & Michael S. Tsirkin & { NEEDS_RESET: trivial clarificat=
ion
-
-If device sets NEEDS_RESET before DRIVER_OK, it
-can't send notifications to driver.
-
-Make this clear.
-
- } \\
-\hline
-373 & 22 May 2014 & Rusty Russell & { Fix build of document
-
-Error introduced in "VIRTIO-98: Add DEVICE_NEEDS_RESET":
-seems that underscores in labels are verboten:
-
-[133] [134] (./virtio-v1.0-csprd02.aux
-
-! Missing \textbackslash endcsname inserted.
-
-<to be read again>
-
-                   \textbackslash unhbox
-
-l.45 ...ts: Device Status Field\}\}\{subsection.1\}\{\}\}
-
- } \\
-\hline
-372 & 22 May 2014 & Rusty Russell & { content.tex: virtio-scsi review (VIR=
TIO-106)
-
-As prompted by Rusty, add a few more MUST/SHOULD items for both devices
-and drivers.  Clarify semantics of max_channel/max_id/max_lun, task_attr
-and task management functions.
-
-(As per minutes of meeting 2014-05-20:
-
-    \url{https://lists.oasis-open.org/archives/virtio/201405/msg00034.html=
} )
-
- } \\
-\hline
-371 & 22 May 2014 & Rusty Russell & { content.tex: add support for protect=
ion information (VIRTIO-108)
-
-This is a new feature that was suggested by Nicholas Bellinger, who
-
-also provided a prototype implementation for vhost-scsi.
-
-(As per minutes of meeting 2014-05-20:
-
-=09\url{https://lists.oasis-open.org/archives/virtio/201405/msg00034.html}=
 )
-
- } \\
-\hline
-370 & 12 May 2014 & Rusty Russell & { VIRTIO-96: Assign device id to virti=
o input
-
-Assign device id to virtio input
-
-As passed at meeting 2014-05-06:
-
-=09\url{https://lists.oasis-open.org/archives/virtio/201405/msg00016.html}
-
- } \\
-\hline
-369 & 12 May 2014 & Rusty Russell & { VIRTIO-52: Make mac field read only.
-
-As passed at meeting 2014-05-06:
-
-=09\url{https://lists.oasis-open.org/archives/virtio/201405/msg00016.html}
-
- } \\
-\hline
-368 & 12 May 2014 & Rusty Russell & { VIRTIO-107: Clarify net mac commands=
.
-
-As passed at meeting 2014-05-06:
-
-    \url{https://lists.oasis-open.org/archives/virtio/201405/msg00016.html=
}
-
- } \\
-\hline
-367 & 12 May 2014 & Rusty Russell & { VIRTIO-98: Add DEVICE_NEEDS_RESET.
-
-As passed at meeting 2014-05-06:
-
-        \url{https://lists.oasis-open.org/archives/virtio/201405/msg00016.=
html}
-
- } \\
-\hline
-366 & 12 May 2014 & Rusty Russell & { VIRTIO-87: limit descriptor chain le=
ngth even with INDIRECT.
-
-As passed at meeting 2014-05-06:
-
-        \url{https://lists.oasis-open.org/archives/virtio/201405/msg00016.=
html}
-
- } \\
-\hline
-365 & 12 May 2014 & Rusty Russell & { VIRTIO-103: PCI: Note that turning o=
ff queue_enable is not supported.
-
-As passed at meeting 2014-05-06:
-
-        \url{https://lists.oasis-open.org/archives/virtio/201405/msg00016.=
html}
-
- } \\
-\hline
-364 & 12 May 2014 & Rusty Russell & { VIRTIO-103: PCI: require read-after-=
write on device_status reset.
-
-As passed at meeting 2014-05-06:
-
-        \url{https://lists.oasis-open.org/archives/virtio/201405/msg00016.=
html}
-
- } \\
-\hline
-363 & 12 May 2014 & Rusty Russell & { VIRTIO-99: Typo fixes.
-
-As passed at meeting 2014-05-06:
-
-=09\url{https://lists.oasis-open.org/archives/virtio/201405/msg00016.html}
-
- } \\
-\hline
-362 & 07 May 2014 & Cornelia Huck & { net: fix device conformance sections
-
-For the network device, we had two device normative sections both called
-"setting up receive buffers", neither of which was referenced in the
-conformance section.
-
-Let's rename the second one to "processing of packets" which seems to
-better match the actual contents and reference both of them from the
-conformance statement for network devices.
-
-Resolves VIRTIO-97.
-
-Agreed on the 2014/05/06 TC meeting.
-
- } \\
-\hline
-361 & 07 Apr 2014 & Michael S. Tsirkin & { conformance.tex: fix references=
 to mmio
-
-Both device and driver conformance referred to ccw twice; let's add the
-correct mmio references.
-
- } \\
-\hline
--=20
2.20.1


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

