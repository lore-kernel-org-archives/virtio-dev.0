Return-Path: <virtio-dev-return-12342-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FF9C7618E
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:54:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 731892A826
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:54:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 63D3D986640
	for <virtio-dev@archiver.kernel.org>; Fri, 21 Apr 2023 14:54:55 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 59485983FEB; Fri, 21 Apr 2023 14:54:55 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4681D986636;
	Fri, 21 Apr 2023 14:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPqfvMqo0D4J732xq/A3CQJHex8iOX0LLM/Zgfi8fFL+oO2DlxliiYYNt+0PFmTMIogd4GQylwFJKP4T88ViaeUcRDVj2FNIEbuvkOTzfdUJys9Vdh8A4NVtE0kQhdrdZ6DnblIU4XoRrx5HIrYExZJeeq5bTAbI8LGE7mYBPOEdVw2/4yXv3KLVgZNQ6yMnKj4SwTU9QrsAqjnDTJ/EX0lxv8ueEZPMyiz0i1AV5EuiB6gY4/oqKztn3ff2RAoJt9jDgerTXu5wKfie8anVZ1bg/YUZPCGPDNyrfC1DcJqaTe/Wsw5bxiwr6zV9wU7L3/aUT/GRQpzq+aj8Pr0BZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRRBo37xa3RhlpF0f9FO/ZF813OIJCcEZNEGccrNSlA=;
 b=dkH47O0IZgrZnsXku0PLLfaH5sN/Pg+cDr+VRMVKaq95Bo0yEp697WmLypQm4uMZqMi7XS9HMKH1xhHxsGYAI1NUAxU5xA2+68NwGhd4Zq2qYMQ2yZssUkyLDBGiGrVKpV4529JdJU6IrwJ0if11j5mld1XEwAnklhqH6XAIp2YPtbyi2xd/jcbu1MkJ07XeqTeJxrFORMdxVRqrlDCCyC4ECDiPi6ic8oUaFMlHB/NQdv5dH4servJGIe/88tZrgA+P35JSXdORbuWSzaSReYfMmNKVYIG2hzOx9xBimoWxbS6bmtSuDjYJPS3/3zeHGLbYdj1YCSTeEvtzP1NZtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Fri, 21 Apr 2023 17:54:32 +0300
Message-ID: <20230421145434.83774-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|CH2PR12MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e6b50b-3ae3-478e-c8d3-08db42785bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GZcaGTrnyJfEr/FQJyMNtq8Uuy5qvGIB5kU81++jxruBVciOff6b+hlWzxsOamYvJePQ1xBRI2Wun4ocW4p61Zw5pAbk5c9+6uperIowzsE5SpK7xzWfrMwmG6wfVOCE7kGWIXAlSHmkLaUgNMKR80AQCH/aG9hH8qUhyA1lUd8lkjFS6zfXt/We+aLAGAXigdavvz1xhbOFm4cWwQNeR+lXBQT0vcE6v8E4IYBRtEAk7OToVkDqq9NMhYrHIknBLS4C/wetlybYPE9k+7aVm/UrKNz07pWmWe055z6+MMuUG1nyH374AMNi3rA1cJsAH2dR8+iPKtB6kas6RVCq0jlXneL6Od0jpm17scxwGJpERV5QM25N7TlQ78lelnUHE4shrC6kcoqfgSs23wXRTFL5isOOeihKoeeu/xIPZ1n2FqzYmiMUiiKTJdaVvdPzktinA8DZpNXH6zII8oFLAtzedZSMR4v0M2W4XPz9JHChpizknCiVRuUwWBvH1KkvYdWOKffmhYtq/duYhpKG6fV21nIF4BQSWFWgsnN6blxBaS/OvcpyfJL8kAzpeI0MbsNfcg4OomKxIEqxXnyzT2tEQv2hGoIp5Zj+McGR9o3WoFzKYD48qhM48R8bLi6wYstF90siLwZgPrzHs728lzeBjFl+zM7Bhw3XZazYcjVHuUbnynbnC4cAzBOT9e2f1bM+KwXlIUeLMcfafmuNDJDIncNU74OpBLG1UQM599bea6eqg8Ct8iRkrrD+FGSkgEzLvAQfrABeBIY8h2XFXUe86NzFFMEhzVqfdXCAiS0=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(107886003)(41300700001)(186003)(1076003)(26005)(5660300002)(54906003)(478600001)(110136005)(70206006)(70586007)(2906002)(4744005)(4326008)(316002)(6666004)(40460700003)(356005)(7636003)(82310400005)(16526019)(8676002)(8936002)(36860700001)(83380400001)(34020700004)(86362001)(82740400003)(36756003)(336012)(47076005)(2616005)(40480700001)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 14:54:50.5095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e6b50b-3ae3-478e-c8d3-08db42785bc4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4905
Subject: [virtio-dev] [PATCH v3 0/2] transport-pci: msix register desc improve

Problem:

Current wording queue_msix_vector and config_msix_vector says
"for MSI-X", which is bit confusing.

config_msix_vector and queue_msix_vector are the msix vector
number for configuration change and queue related interrupts.

Hence, reword it.

---
changelog:
v2->v3:
- reword
v1->v2:
- rewrote to indicate MSI-X table entry index
v0->v1:
- added 'here'
- dropped 'receiving'
- dropped already merged patch for empty line


Parav Pandit (2):
  transport-pci: Improve config msix vector description
  transport-pci: Improve queue msix vector register desc

 transport-pci.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

