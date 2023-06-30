Return-Path: <virtio-dev-return-13186-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE31EB64D7
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 09:54:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E56132B01F
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 09:54:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF0CF9866F8
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 09:54:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A88B79865E9; Fri, 30 Jun 2023 09:54:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 96F069866ED;
	Fri, 30 Jun 2023 09:54:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ef79TGGmCPhxFZITKVBvXQ9bw2yNGA3tFrCgbcpbLtNsfSa+QLct/02TS802Jt9RmtQxTf04G+TX8iGVS1UcjIzDyRYVYACzfecSPi1lYwpLh7cVzppdYUwugs7qrXrbdx13cT63EutbL2tmQh9lz8AjH9Z+8NnTOlVwwbscBHGjOR43MU0PqLmBJj0HnslPXL8NkL02cdXL7Vi5bIWtRe2jzXmNsG8yOhgJH+19VPClyCQz+BNlIS4Vn5eUlsbuOb0n3YCttydavWl3vM7cEf16aa7s/I/HRvCqZjAegMxVLz28MSckGdzZK0qqZqJC+BTfxrEiedq8DTHs3XBzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ae8zgfAN4HUHJLunQvCxN6yW9ciYfi+d4cRr1A5nB0=;
 b=FdVP01kqqWGuiLo/L9p+IdD4b+WMpnw7yI7LsDXNqoBlpGurmU2gMzwW0zXh13sM6B+T8uHrpmf9Fg0ne/Hll1bQ6qPhcu0kvKAz9ka5WcSWIL+3Knf213+Tv9KlP6WUy2owX3+VOJRArpko+mznwNl2SSXRWO1U5moPPY+3Uy03nh2GaTwoAyZFUVqe73lITU22dslU2szeKakqmIUI+KcYKR/IhgCp5PlYPml15vOsQdG1oBtlI3+cPFLrz2Eokg8Fg0KUUWtdzj018d96TR/Irpi8sJynAc5/z4DR59hdl54U/ACIEP9yNgSzRBy2aYIEY2om7rE0/fSPh7Dflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.oasis-open.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: <virtio-comment@lists.oasis-open.org>, <virtio-dev@lists.oasis-open.org>
CC: Jiqian Chen <Jiqian.Chen@amd.com>
Date: Fri, 30 Jun 2023 17:53:43 +0800
Message-ID: <20230630095344.856316-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT074:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: d11c5cc7-58a6-4593-0c7d-08db794fee81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ZMQfPYSM68zm79V7CsBV+XSBLHUet+VQhpnGIx5giPHa7rC95QxKzNxVmBVnvzQsZqIosYcbcd4QuHQ4bBFH8CXkVJW4dsSQwUsTTSzi5yw1aWLaaFMsMr/zVN0QPKy47J9CEsAvUdHMvlXo2XUKmyDXOgX3+h7iVS+hyaCPawu4mO0dGJ78cO7RXpMFtgk1FT7vrX08A1I3VlpLNdJta4d0ps9sonkVdE8+uqJy0IMVd5U06MmQVVMQfg4jDueLPVtyto7yDrd9xf317SS8gRmGVBoyAxuARt6vQzqrf02Kr2HduiNxIc7djbO8DZ2VBwWvA5bShHyxGrliqLjl5D8GWg42JbZ633ubZIaLSUxDxEUYSiZ9yjtQLOdivOx2S7Eyq1rQFTAjYT0j5heVgI/JDfXcCuieDU1FU7OhnV5dSgzbPA+sON0RdFEyBhF00Eg9cR0nyBySmrdbXnpAmHN1FXwLzmZ5TR4M7XUfSfQE6YJZ+ubg6rTNAo7dbe6WaJdzktt0XrXmee2cNKCLXTVo/FoGKhKHihkAEobQOUGi8ZzoJxO9fyu66g1paeswU9kQWCa+HlVPCxBpJlfvtMDN31YfBJC7/6GPosOGOC8P4Vy9B6kY0GOjmGeHzv1FLg2Uhmf8XGaH+eaU2E0lWmHMbpkqyxT5ImK51n3zKQguKGCQP1oNI3t0A551ZorglTJg2ykb2EuObJDa6YRzjs2tBziEliIINlDvX6CkjY6dn1XAns3wqSnEw011MmDH8cCEcf+m/KwNoL1bqaontKNaAx1WZn15acI/DMAj2/k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(46966006)(40470700004)(36840700001)(26005)(2906002)(86362001)(356005)(82310400005)(7696005)(6666004)(83380400001)(81166007)(2616005)(186003)(336012)(16526019)(426003)(47076005)(82740400003)(40460700003)(966005)(110136005)(41300700001)(36860700001)(40480700001)(4326008)(478600001)(36756003)(70586007)(450100002)(316002)(70206006)(1076003)(5660300002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 09:54:01.3400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11c5cc7-58a6-4593-0c7d-08db794fee81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT074.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535
Subject: [virtio-dev] [VIRTIO GPU PATCH 0/1] Add new feature flag VIRTIO_GPU_F_FREEZING

Hi all,

I am working to implement virtgpu S3 function on Xen.

Currently on Xen, if we start a guest through Qemu with enabling virtgpu,
and then suspend and s3resume guest. We can find that the guest kernel
comes back, but the display doesn't. It just shown a black screen.

That is because when guest was during suspending, it called into Qemu and
Qemu destroyed all resources and reset renderer. This made the display
gone after guest resumed.

So, I add a mechanism that when guest is suspending, it will notify Qemu,
and then Qemu will not destroy resources. That can help guest's display
come back.

As discussed and suggested by Robert Beckett and Gerd Hoffmann on v1
qemu's mailing list. Due to that mechanism needs cooperation between
guest and host. What's more, as virtio drivers by design paravirt
drivers, it is reasonable for guest to accept some cooperation with host
to manage suspend/resume. So I request to add a new feature flag, so that
guest and host can negotiate whenever freezing is supported or not.

Attach the patches of Qemu and kernel:
        Qemu
                v1: https://lore.kernel.org/qemu-devel/20230608025655.1674357-2-Jiqian.Chen@amd.com/
                v2: https://lore.kernel.org/qemu-devel/20230630070016.841459-1-Jiqian.Chen@amd.com/T/#t
        Kernel
                v1: https://lore.kernel.org/lkml/20230608063857.1677973-1-Jiqian.Chen@amd.com/
                v2: https://lore.kernel.org/lkml/20230630073448.842767-1-Jiqian.Chen@amd.com/T/#t

Best regards,
Jiqian Chen.

Jiqian Chen (1):
  virtio-gpu: Add new feature flag VIRTIO_GPU_F_FREEZING

 device-types/gpu/description.tex | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

-- 
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

