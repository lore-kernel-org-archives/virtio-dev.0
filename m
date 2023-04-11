Return-Path: <virtio-dev-return-12150-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DC0C76196
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:43:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7481A26CE
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:43:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B1A19865F6
	for <virtio-dev@archiver.kernel.org>; Tue, 11 Apr 2023 19:43:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 61106986371; Tue, 11 Apr 2023 19:43:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 48FBB9863A4;
	Tue, 11 Apr 2023 19:42:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVvH26pdJlF07satcTH/DMBu5m20H9W40rNe5DoYoNt6eTTSjhAZhfBLD8bpZ7NjjIFA8cb8js4c/O4BeI3oU7KbgdWx8SLCVAOj517Zw4tuoYKCK+eR88G/baR2l675KPRFEvT22bJjCMkyXq/yE306HR8gLgwGwJBzrM6p3m2kMaRYXpGUm3zVuywJzyzmi0BCZ+Veck2CzwpLHJ7rzTUFw4O7u+ivGv2TSdH1ffzumSmvtHPCFN4fhpeq3+M4/Hh/FwwBGtR6jVX7LyJbKwUWgalL0URKOVTy736DtNphBCeOEjv3vX9RmpG8yCut6eUQOGpYbFZcBnGeYzWBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJ6Blg4RQuxZ4e7AwyjM7ZcsCk9HP69HF3YaFT+gkME=;
 b=Z0S/Bu933nglmBVYKMYcDhWU3DcaG/c1rkZ4sGumKWNZV6lOKwgFlVsr6APo0mnQWd5Z7PKcMfwZl8prXclKi3kzqGyNimqPZ2BmtUCNp8PkCeJN1KkaBUFIheg/otLlvtYesd8A9m1Rd9YY7BD8qeyE958ilxoM1F9LFQKNhTk9W++0gZd8SA/W6AVVZ2kGcxyXFUDBVFs5/awS47bkLN45eh6eTLCVM+8g39L/SBRXE0rfZgAo5KACUfCURfjTcqexrb3mjcS2vuHncuwykYGv4Bh/Ygtmati/mJ2Gvx7utczYhO77NRkgzzpZUFmANlqShCRz/kduQDnPEpIZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
From: Parav Pandit <parav@nvidia.com>
To: <mst@redhat.com>, <virtio-dev@lists.oasis-open.org>,
	<pasic@linux.ibm.com>, <cohuck@redhat.com>
CC: <virtio-comment@lists.oasis-open.org>, <shahafs@nvidia.com>, Parav Pandit
	<parav@nvidia.com>
Date: Tue, 11 Apr 2023 22:42:18 +0300
Message-ID: <20230411194220.752355-1-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 41227c66-9271-4665-166b-08db3ac4f002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d1exRuaEpMNDuBBld4KclqHDrei4hvXlnX6W6OK5teI/zYrpdDUfpXX9yMobcnKjwstTpnJSJPmQH5bHDsB851ZjURTXgwspphRl/gE9W90Sm0idpywUcJC37M1tOt8u22TB9QW2rK+hwGlPZ+OJgBBBHR0DzTXUf85Qk1efljyxK7qtyklZBqT6OgPrrzTVbZ5ZwrKF9AxU4UdNhinfYP4MP167RetIjsjtDVB8DRXcE95as3WaCTN0tTKmniTEEyswXmGzk4Ru4YqQPeJjPOMj1u2nYf5xywXickv6MY+iD2Lk1z7Z9daXI182fsEjUttpg/fskqvRcngoLzJnhujqksy8OcL43VMG/gM+12wYzPTqEDet3NSHQ22nJbKNF0K+qRqAHMNrv29EH3TjpQhCWfaqVbzm0UqJxLFUafOAwqBAyWKTOW2MEtGpyZbF32ibDiFlrTZ+zJ7bRUcdLC9+w5gw2VeXD4QfI+QKR924CMmryfSWjMNgXfg/lf3aX2D8014NLi8ZKFLNuVgFVFbrn3SUXqwwCKixWKo12+/6h0tPDvuHsMH6MF2eASYV2993F6tVqi1xN5dAsAM5GLpTMAva/Bq+w/EQuROr2I4/NbVYYDYpjdGmSuRo/R38fa0qgAF+O11pIByw8dT56FuEQyrteA+9VT9t9Gn9jZpoK+FBcetYRyYLE98AR2gzgBwd+DbQUqZB6Zldwdfg2gyCPxOeQxq40HfF9TH41ccw6IxlV5K0RBhiLvmC/c+l9e56pIrkaXufyqoS7Vn64Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(376002)(136003)(451199021)(46966006)(40470700004)(36840700001)(86362001)(82310400005)(36756003)(4744005)(2906002)(478600001)(40480700001)(36860700001)(6666004)(34070700002)(426003)(186003)(47076005)(336012)(107886003)(16526019)(1076003)(26005)(83380400001)(70206006)(40460700003)(82740400003)(70586007)(8676002)(4326008)(54906003)(5660300002)(2616005)(110136005)(41300700001)(356005)(7636003)(316002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 19:42:51.6164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41227c66-9271-4665-166b-08db3ac4f002
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614
Subject: [virtio-dev] [PATCH 0/2] transport-pci: msix register desc improve

Problem:

Current wording queue_msix_vector and config_msix_vector says
"for MSI-X", which is bit confusing.

config_msix_vector and queue_msix_vector are the msix vector
number for configuration change and queue related interrupts.

Hence, reword it.

---
changelog:
v0->v1:
- added 'here'
- dropped 'receiving'
- dropped already merged patch for empty line

Parav Pandit (2):
  transport-pci: Improve config msix vector description
  transport-pci: Improve queue msix vector register desc

 transport-pci.tex | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

