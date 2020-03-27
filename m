Return-Path: virtio-comment-return-1160-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Mar 2020 10:37:57 +0000
Message-Id: <20200327103803.10460-3-alex.bennee@linaro.org>
In-Reply-To: <20200327103803.10460-1-alex.bennee@linaro.org>
References: <20200327103803.10460-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Subject: [virtio-comment] [RFC PATCH  2/8] CONTRIBUTING.md: convert to proper MarkDown
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 CONTRIBUTING.md | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 1330a98..f07cb32 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -1,20 +1,12 @@
-<div>
-<h2>Repository Contributions, Participation, and Public Access</h2>
+Repository Contributions, Participation, and Public Access
+----------------------------------------------------------
=20
-<p><b>Who may Contribute?</b> Contributors to <a href=3D"https://github.co=
m/oasis-tcs/virtio-spec/">this repository</a> are expected to be <a href=3D=
"https://www.oasis-open.org/policies-guidelines/oasis-defined-terms-2017-05=
-26#dMember">Members</a> of the
-<a href=3D"https://www.oasis-open.org/committees/virtio/">OASIS Virtual I/=
O Device (VIRTIO) TC</a>, for any
-substantive contributions.  Anyone wishing to <a href=3D"https://www.oasis=
-open.org/org/faq#committee-participation">participate</a>
-in the TC's technical activity is invited to <a href=3D"https://www.oasis-=
open.org/committees/join">join</a> as a TC Member.
-<i>Member</i> in this context means any TC role or office other than OASIS=
 TC Observer, per
-<a href=3D"https://www.oasis-open.org/policies-guidelines/tc-process#membe=
rship">TC Process</a>
-(Member, Voting Member, Persistent Non-Voting Member; Chair, Secretary...)=
</p>
+**Who may Contribute?** Contributors to [this repository](https://github.c=
om/oasis-tcs/virtio-spec/) are expected to be [Members](https://www.oasis-o=
pen.org/policies-guidelines/oasis-defined-terms-2017-05-26#dMember) of the =
[OASIS Virtual I/O Device (VIRTIO) TC](https://www.oasis-open.org/committee=
s/virtio/), for any substantive contributions. Anyone wishing to [participa=
te](https://www.oasis-open.org/org/faq#committee-participation) in the TC's=
 technical activity is invited to [join](https://www.oasis-open.org/committ=
ees/join) as a TC Member. _Member_ in this context means any TC role or off=
ice other than OASIS TC Observer, per [TC Process](https://www.oasis-open.o=
rg/policies-guidelines/tc-process#membership) (Member, Voting Member, Persi=
stent Non-Voting Member; Chair, Secretary...)
=20
-<p>Persons who are not TC members are invited to open issues and provide c=
omments using this repository's <a href=3D"https://github.com/oasis-tcs/vir=
tio-spec/issues/new">GitHub Issues</a> tracking facility or using the
-TC's <a href=3D"https://www.oasis-open.org/committees/comments/index.php?w=
g_abbrev=3Dvirtio">comment list</a>.  All such content created in GitHub Is=
sues and/or posted to the TC's <a href=3D"https://lists.oasis-open.org/arch=
ives/virtio-comment/">archived comment list</a> is governed by the terms of=
 the <a href=3D"https://www.oasis-open.org/policies-guidelines/ipr#appendix=
a">OASIS Feedback License</a>.</p>
+Persons who are not TC members are invited to open issues and provide comm=
ents using this repository's [GitHub Issues](https://github.com/oasis-tcs/v=
irtio-spec/issues/new) tracking facility or using the TC's [comment list](h=
ttps://www.oasis-open.org/committees/comments/index.php?wg_abbrev=3Dvirtio)=
. All such content created in GitHub Issues and/or posted to the TC's [arch=
ived comment list](https://lists.oasis-open.org/archives/virtio-comment/) i=
s governed by the terms of the [OASIS Feedback License](https://www.oasis-o=
pen.org/policies-guidelines/ipr#appendixa).
=20
-<p><b>Use of Contributions</b>.  As with all OASIS Technical Committee ass=
ets (TC <a href=3D"https://wiki.oasis-open.org/">Wiki</a>, TC <a href=3D"ht=
tps://issues.oasis-open.org/secure/Dashboard.jspa">Issues Tracker</a>, TC <=
a href=3D"https://lists.oasis-open.org/archives/">General Discussion List a=
rchives</a>, TC <a href=3D"http://docs.oasis-open.org/">OASIS Library</a> a=
ssets), content placed into this GitHub repository is visible and publicly =
accessible.  Subject to applicable <a href=3D"https://github.com/oasis-tcs/=
virtio-spec/blob/master/LICENSE.md">licensing</a> rules, the repository con=
tent may be re-used freely, including the creation and publication of deriv=
ative works.</p>
+**Use of Contributions**. As with all OASIS Technical Committee assets (TC=
 [Wiki](https://wiki.oasis-open.org/), TC [Issues Tracker](https://issues.o=
asis-open.org/secure/Dashboard.jspa), TC [General Discussion List archives]=
(https://lists.oasis-open.org/archives/), TC [OASIS Library](http://docs.oa=
sis-open.org/) assets), content placed into this GitHub repository is visib=
le and publicly accessible. Subject to applicable [licensing](https://githu=
b.com/oasis-tcs/virtio-spec/blob/master/LICENSE.md) rules, the repository c=
ontent may be re-used freely, including the creation and publication of der=
ivative works.
=20
-<p><b>Cloning and forking</b>. May users clone and fork this repository?  =
Yes. Just as versioned content maintained in any OASIS TC's <a href=3D"http=
s://tools.oasis-open.org/version-control/browse/">SVN/Subversion repository=
</a> may be checked out to a remote SVN repository and used by anyone, this=
 GitHub repository may be forked or cloned for use by any party.  Compare, =
<i>e.g.</i>, <tt>svn checkout https://tools.oasis-open.org/version-control/=
svn/dita/trunk/doctypes/ dita-doctypes</tt>.</p>
+**Cloning and forking**. May users clone and fork this repository? Yes. Ju=
st as versioned content maintained in any OASIS TC's [SVN/Subversion reposi=
tory](https://tools.oasis-open.org/version-control/browse/) may be checked =
out to a remote SVN repository and used by anyone, this GitHub repository m=
ay be forked or cloned for use by any party. Compare, _e.g._, svn checkout =
https://tools.oasis-open.org/version-control/svn/dita/trunk/doctypes/ dita-=
doctypes.
=20
-<p>Please see the <a href=3D"https://github.com/oasis-tcs/virtio-spec/blob=
/master/README.md">README</a> for general description of this repository, a=
nd the <a href=3D"https://github.com/oasis-tcs/virtio-spec/blob/master/LICE=
NSE.md">LICENSE</a> file for licensing.</p>
-</div>
+Please see the [README](https://github.com/oasis-tcs/virtio-spec/blob/mast=
er/README.md) for general description of this repository, and the [LICENSE]=
(https://github.com/oasis-tcs/virtio-spec/blob/master/LICENSE.md) file for =
licensing.
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

