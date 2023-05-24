Return-Path: <virtio-dev-return-12811-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1D3C77B7A
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 11:34:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1FA5B4454F
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 11:33:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0F653986559
	for <virtio-dev@archiver.kernel.org>; Wed, 24 May 2023 11:33:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1EFB39864A6; Wed, 24 May 2023 11:33:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F21E986555;
	Wed, 24 May 2023 11:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1684928017.853000
X-TM-MAIL-UUID: 5980e58f-9c6e-4ec7-a993-18559d2b9a03
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l7/zIrdrU3Ll1wVgsWtg10TAvNQx9ktcPrWQGvhPh/1iEZN1FMoJ94E7YzG4GRD1p84MPS7wZ3LfUUYvH0a6zCbrrGA5/3plnkLfWo9zhY2kjkYc1B+2NjMcHQhq75AMAfJvqpGJH8HV7A80s71B6EOW69w767XtPgQYhnaNdY2TSr6gDKJqfthbeWsgAun7Fn3N6KxZJzwhl29kW7d6c7vkIVVnXOjJyDYtwwoYwOXlgF4RjI5e47AFuZEIGQnXyCDQXH3bJsnMb4lxsaqPyvmTPo+cERyNVEVkimSWuA9cQb5jCY7cGSO973x24JpGFynisfhehjBbwRsngYS9mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYMJvvMge2Fgq3COEVWDU7Aphw/BiNW/USO3VGFQD1c=;
 b=lRlpK2EMssx1KtT+sF6NQHUqJ6P9agICpZG5duTdyZwnxTBHiRIrZTdF85sjsoTYICOJJTNGyq5WCRJShbLZK+N9XCLpPpTJPAiEETqtLHJnslaZi5AWTQ4agdmhcPdcVCPiKXDYOv3CNjetkFpaKA7XmQo9g8c/8aQR/jedLh/7m1/ErGCrMg/W+edNsuOdWiXL0K70a+H27oxqLLRQD2p8qhrIuagpSRkbfen2TfwhMMX4hbOrjQlw+MAoJgFmb2Vmq6Y4F+F4cmIzdfbmgie+WguFpQjsroHs0RpP47RKO1E+0hqyY1tN4b7SjKiroDLsExa6goPxz5ak8HHClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=chromium.org smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Alexander Gordeev <Alexander.Gordeev@opensynergy.com>
To: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org,
	Albert Esteve <aesteve@redhat.com>,
	Alexandre Courbot <acourbot@chromium.org>,
	alex.bennee@linaro.org,
	Andrew Gazizov <andrew.gazizov@opensynergy.com>,
	Andrii Cherniavskyi <andrii.cherniavskyi@opensynergy.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Enric Balletbo i Serra <eballetb@redhat.com>,
	Enrico Granata <egranata@google.com>,
	Gustavo Padovan <gustavo.padovan@collabora.com>,
	Keiichi Watanabe <keiichiw@chromium.org>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Marcin Wojtas <mwojtas@google.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	Tomasz Figa <tfiga@chromium.org>,
	Matti.Moell@opensynergy.com,
	bag@semihalf.com,
	bgrzesik@google.com,
	hmazur@google.com,
	mikrawczyk@google.com,
	srosek@google.com,
	zyta@google.com
Cc: Alexander Gordeev <Alexander.Gordeev@opensynergy.com>
Date: Wed, 24 May 2023 13:33:17 +0200
Message-Id: <20230524113318.518692-1-Alexander.Gordeev@opensynergy.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT059:EE_|FRYP281MB2507:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 54e45f75-63a4-4fef-1bed-08db5c4ab683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/8iWuIJOPeh4uB2oqB/1XJaSsQLKgQEuPHY479cHQlN4CPNOb5cWn27D0N0BJdkL+z/C5wA1yiw2kVThF4rweglf0H8MvYSpHYyeL/zAam42DBmXDaoi0v2lJ9wx5cu9WCewUvHrJYIMq/icmTlLCyStFPsFGng31yHJuekcCaDwS9LImxTQAOzd6ZQhWqyhYbrXWuFl1TaBF4oV+JX6RzF2EJ8vQEEkuRHsEA/siz29XYBlNpGlIS3fmEzJw3jkeu/QB6nbkyzcdHGmEv9nGtGc03n+Krx577EIY5WLzXKtiWImvRkQlY2m9fA7rXriyh/yC0IIr0zxzXIk37oNbQbWiaxvieg4uazLE4MsVwZkgPe9pUhlB6tSWrQRSCcT+andkIzQlEQYnuIlH2bfQvDNzdJXH8Iipb0hnmygqUUPr4s0+nzQ/cUOY124r5TQZVjSDTvIey4gZO33+99hb4k08jyy+CPqM5PBm9eAz6zRJ4K03L3YNyEjCbpb+ELwNS7y2UXmgaKP8KpGhZx1b6qok8YWjEWLdthOBSEa27WiIIr1cs/8JA7Tf3UaIWxynluYnLQtl+pZcUB1QNIaNniYWzXgOKQVIhGru8OVjBo5LbbF2sPM+tX9C/xk1a3XrfyurQosA1DZDPIuxezqGrl4Q2sGYIdsmVEPUZHjvqfr+6YgBuuqmay2KJNeb6BCb6VyD5qW5knARPlIw6JzuPiqdGgzJ+lNnNLGdNff0LHo5evUyOEVXUBh/ySIi2Tp7RRNtj4bBdJMdz/VQCwD5sWj0uMhjkNDbZD+xK7IDtcq2neFyHOhM6m13xdxXGUR
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(396003)(376002)(39840400004)(346002)(136003)(451199021)(46966006)(36840700001)(8936002)(8676002)(5660300002)(86362001)(81166007)(966005)(921005)(40480700001)(1076003)(336012)(26005)(2906002)(186003)(2616005)(82310400005)(36756003)(7416002)(47076005)(107886003)(83380400001)(4326008)(70586007)(70206006)(316002)(110136005)(42186006)(36860700001)(41300700001)(478600001)(5930299015)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 11:33:36.1656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e45f75-63a4-4fef-1bed-08db5c4ab683
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT059.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2507
X-TM-AS-ERS: 104.47.7.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27646.007
X-TMASE-Result: 10--8.973100-4.000000
X-TMASE-MatchedRID: rWtD0ETMaamUXVriansmf3zmmMD/HXF+TFQnI+epPIaI5MhceLdXJeRZ
	+ls/484h3XPZfRGoUBWYzhQiFVpWEyQTVDh2tvJD9Ib/6w+1lWRPnKxAOPp4WQ6QlBHhBZuwS5n
	GZLbO/xOKhzwq031iGNl/VWA7eDAeiwYbHHVZggvfqVBdB7I8UWlYsa84w2hT1YzbHoRn9L3RfH
	tItiRZWdmajARvePUpQvDfXpsV7A1R+Y5d0bm9QJXi1z8zt1TR56ZiKymUcU7XVz+0X8Drq2VYY
	C40jpLGhCYXJKnjJJLzJ86KNhXJMqUJLwW4Uqdaxvp0tuDMx3mS3ydFEIGNTkekR3VSvOYV2dV1
	w++5WjMNUccATRyd1FM67ebhB/uCByXoV4XT2B5Dk5poSYXNl6cQHepotRmtkV09xNX02/43KV6
	TwldBN62EXtg//CUCGT9iMGK+E4NUaz8ayo4K5h1qGr6sYOf/rOCEGIPhtwjozDhGeQC9Et/O0T
	kwpBlDezEj+0i6bhi8HO1hAUuG+1rOnzqOHaLKfXVm6YO5Gnt9LQinZ4QefBTJFL84IP3FlR1cT
	9YafQWBkH6ve8DfyeloYgzjonrsOwBXM346/+wkbIsFb0He/HSgKTNG7R+iXXGSJJWtaZkt0sPg
	+WiHt1pb9c/Yq9vb
X-TMASE-XGENCLOUD: 629a8e95-b28a-4de7-b2ee-44d8275bbf82-0-0-200-0
X-TM-Deliver-Signature: AB2E11DBCCA468D9C91F32B5BD263E9F
X-TM-Addin-Auth: lAJgH4bCqP6H+XFGNcaNTwfWbMSQM+dg3AOP1DlGT922sL3XKiCAHnJ9xPy
	Bi6xQaK/svMbrLTvPuzDMGeaqpARA8KBL5xXIYs/bZSFGEYJNzSAMiIwFWi+VSGlKXwfWhIBViL
	/06nt4nXeA12gcNxzFKjvGPOCSSK3FaDxdqeJRBDPDxE+FKENUGh6NEj8QtaIIBTnRNDVqFdm2U
	n40eAFQc+88/1Ta+KbJLYFyLQBwdbBoPUWcxD9q5ZdWzPSthgpUGw0MypNcC+G7U70iLW7PmF8b
	2ux4p6ro8pBvaic30P3l2p89qqLJDl3A6OKt.WJDK9SzEAQFsVv6Huulz0NCMHfqSe1xA+3BtTL
	tOXk2o+MoSgH8i+OxTm6WLPjHTET8qzzCIpD9y1vOpKGetXWDDZLvq/g1ISvoKvFO+rUco3PPZ3
	Vb33+NQvOaOFemdjeaI48Y2sEJSCsbFlbrpAPoNOmM7tMhy8zX0WCH2j01L5TpZZY/5AcXr2J5v
	Tczm9GtMJu0FdNtcUU/REeRSxUdLNGp0NqaFWjRmReRUhsEL8bDWq67xESZYRslpDZovzw7pV+3
	jwhDpPog8nfJyk6es5H1VxR5OvUbdsC9J/s0NSgamxUYPYB137Td1lZu75Dgvpx3arIvpqaPa3f
	fNVQ==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] [RFC PATCH v7 0/1] Virtio video device specification

Hi,

This is the 7th version of virtio-video device patch. Feedback would be much
appreciated. It is still under discussion on virtio-dev mailing list whether
the video device specification should be continued as it is done here, or the
V4L2 stateful decoder API should be used instead. There are many arguments.
Also different parties have different priorities and use-cases. Anyway I hope,
that in this draft I was able to solve some of the long standing issues of the
previous drafts. There're still things to be done like introducing completion
events for asynchronous commands, but these changes are not going to be
controversial, I think.

The biggest conceptual change here is that I reintroduced device parameters
discovery, but in a (hopefully) simpler way. The idea is that the QUERY_CAPS
command should return all the supported parameters and the device capabilities
in one go and in a way compatible with V4L2, so that it is easy to write the
driver. This way the need to query the default values of the parameters before
changing them is reduced because the capabilities are much better known from
the start. This means an extensive use of bitsets in the capabilities. Here I
took some ideas from the crypto device specification. Also I turned
GET_PARAM + SET_PARAM command into a single SET_PARAMS command again
with the help of parameter bitsets. This is a big change, it still has to be
polished. I'm going to do it in the next versions together with updating the
virtio-video driver.

I tried to use directly or reference the existing definitions from V4L2 for
the formats and encoder settings as much as possible. It turns out the raw
formats are defined in DRM much better, than in V4L2. (For example, V4L2 names
RGBA 32 bit format "BGRA32" for some reason.) So for raw formats I gave both
references to DRM and V4L2.

The size of the resulting video section is 23 pages. I'm not sure if it is
possible to this much simple conceptually. Any ideas for shorter and more
precise wording would be much appreciated.

Full PDF: https://drive.google.com/file/d/1Va3LxbFdQ3Odeib4FD-B1CPYSz21Ihha/view?usp=sharing
PDF with the video section only: https://drive.google.com/file/d/1qANJDOpt0R_PvC0QuGaxYXC_Uq70MagC/view?usp=sharing

Changelog v6 -> v7:
* Used changes from Alexandre Courbot's repository on GitHub:
  https://github.com/Gnurou/virtio-video-spec
  They have the same license file as the virtio-spec repository.
  The changes addressed some of the comments to the draft v6.
* The big change in discovering and setting the parameters using QUERY_CAPS
  and SET_PARAMS commands.
* Restored the encoder settings and some of the formats.
* Addressed the remaining comments to the draft v6 or added todo comments.
* Finished renaming STOP to RESET.
* Added references to V4L2 and DRM.
* Added conformance sections.
* Fixed a lot of small issues.
* Reformatted for better readability.

Alexander Gordeev (1):
  virtio-video: Add virtio video device specification

 conformance.tex                           |    4 +
 content.tex                               |    1 +
 device-types/video/description.tex        | 2005 +++++++++++++++++++++
 device-types/video/device-conformance.tex |   24 +
 device-types/video/driver-conformance.tex |   18 +
 introduction.tex                          |   21 +
 6 files changed, 2073 insertions(+)
 create mode 100644 device-types/video/description.tex
 create mode 100644 device-types/video/device-conformance.tex
 create mode 100644 device-types/video/driver-conformance.tex

-- 
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

